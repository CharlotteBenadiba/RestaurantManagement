import psycopg2
from tabulate import tabulate
import json


class RestaurantChoices:
    conn = psycopg2.connect(
        database="RestaurantManagement",
        user="postgres",
        password="New2020Road!",
        host="localhost",
        port="5433",
    )

    conn.autocommit = True
    cursor = conn.cursor()

    @classmethod
    def view(cls):
        query = """
        SELECT item_name AS Name, category AS Category, concat('$', price) AS Price 
        FROM Menu 
        WHERE available = TRUE
        ORDER BY category DESC
        """
        cls.cursor.execute(query)
        results = cls.cursor.fetchall()
        if results:
            headers = [desc[0].upper() for desc in cls.cursor.description]
            print(tabulate(results, headers=headers, tablefmt="fancy_grid"))
        import menu

        menu.restaurant()

    @classmethod
    def insert(cls):
        cu_choice = input("Enter Customer ID: ")
        wa_choice = input("Enter Waiter ID: ")
        while True:
            fo_choice = input(
                "What would you like to order today? (comma-separated item names): "
            )

            # Split the food choice input into individual item names
            item_names = [item.strip() for item in fo_choice.split(",")]

            # Prepare the items JSON array
            items = []
            for item_name in item_names:
                query = """
                SELECT item_id, category, price FROM Menu WHERE item_name = %s AND available = TRUE
                """
                cls.cursor.execute(query, (item_name,))
                details = cls.cursor.fetchone()
                if details:
                    item_id, category, price = details
                    items.append(
                        {
                            "item_id": item_id,
                            "category": category,
                            "price": price,
                            "item_name": item_name,
                        }
                    )
                else:
                    print(f"{item_name} was not found in the menu")
                    break

            if not items:
                continue

            # Convert the items list to JSON
            items_json = json.dumps(items)

            # Prepare the INSERT query
            query = """
            INSERT INTO orders (customer_id, waiter_id, items)
            VALUES (%s, %s, %s)
            """
            cls.cursor.execute(query, (cu_choice, wa_choice, items_json))

            # Commit the transaction
            cls.conn.commit()

            print(f"Order of {item_names} has been created successfully!")
            break

    @classmethod
    def update(cls):
        # updates a food in db table orders
        order_id_input = input("Enter Order ID: ")

        inspect_query = f"""
        SELECT items
        FROM orders
        WHERE order_id = '{order_id_input}'
        """
        cls.cursor.execute(inspect_query)
        order_data = cls.cursor.fetchone()
        cls.conn.commit()

        if not order_data:
            print("Order not found")
            return

        items_list = order_data[0]

        item_names = [item["item_name"] for item in items_list if "item_name" in item]
        item_names_str = ", ".join(item_names)

        print(f"Currently your order is: {item_names_str}")
        change_item = input("Which item would you like to change? ")
        new_item = input("Which item would you like in its place? ")

        new_item_query = f"""
        SELECT item_id, item_name, category, price
        FROM menu
        WHERE item_name = '{new_item}'
        """
        cls.cursor.execute(new_item_query)
        new_item_details = cls.cursor.fetchone()

        if not new_item_details:
            print("New item not found in the menu")
            return

        item_id, item_name, category, price = new_item_details

        change_item_index = item_names.index(change_item)

        # Update the order with new item details
        query2 = f"""
        UPDATE orders
        SET items = jsonb_set(
            items::jsonb,
            '{{{change_item_index}}}',
            '{{"item_id": "{item_id}", "item_name": "{item_name}", "category": "{category}", "price": "{price}"}}',
            true
        )
        WHERE order_id = '{order_id_input}'
        """
        cls.cursor.execute(query2)
        cls.conn.commit()
        print(f"We have changed {change_item} to {new_item}")

    @classmethod
    def cancelled(cls):
        # updates the db table orders changing cancelled from NULL to current_datetime
        order_id_input = input("Enter Order ID: ")
        query = f"""
        UPDATE Orders
        SET cancelled = TRUE
        WHERE order_id = '{order_id_input}'
        """
        cls.cursor.execute(query)
        print(f"The food for Order ID '{order_id_input}' has been cancelled")

    @classmethod
    def complete(cls):
        # updates order_complete column in orders table from FALSE to TRUE and adds the amount paid to the db
        order_id_input = input("Enter Order ID: ")
        query2 = """
        SELECT total_price
        FROM orders
        WHERE order_id = %s
        """
        cls.cursor.execute(query2, (order_id_input,))
        result = cls.cursor.fetchone()

        if result:
            total_price = float(result[0])
            print(f"Your total is: £{total_price}")

            pm_input = input("Enter Payment Method (1-4): ")

            amount_paid = 0.0

            while amount_paid < total_price:
                am_input = float(input("How much would you like to pay?: "))
                amount_paid += am_input

                if amount_paid >= total_price:
                    query_p = """
                    UPDATE Orders
                    SET payment_method_id = %s
                    WHERE order_id = %s
                    """
                    cls.cursor.execute(
                        query_p,
                        (
                            pm_input,
                            order_id_input,
                        ),
                    )

                    query_a = """
                    UPDATE Orders
                    SET amount_paid = %s
                    WHERE order_id = %s
                    """
                    cls.cursor.execute(
                        query_a,
                        (
                            am_input,
                            order_id_input,
                        ),
                    )

                    query = """
                    UPDATE Orders
                    SET order_complete = TRUE
                    WHERE order_id = %s
                    """
                    cls.cursor.execute(query, (order_id_input,))
                    print(
                        f"Order Total was £{total_price}. You have paid the amount of £{am_input} for your order successfully. The order is now closed, thank you!"
                    )
                else:
                    print(
                        f"Order Total: £{total_price}. You still owe {total_price - amount_paid}"
                    )
                cls.conn.commit()

    def close_connection(cls):
        cls.conn.close()
