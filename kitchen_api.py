import psycopg2
import menu


class KitchenChoices:
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
    def update_pf(cls):
        # updates the db table orders changing prepare_order from FALSE to TRUE
        order_id_input = input("Enter Order ID: ")
        query = f"""
        UPDATE Orders
        SET prepare_order = TRUE
        WHERE order_id = '{order_id_input}'
        """
        cls.cursor.execute(query)
        cls.conn.commit()
        print(f"The food for Order ID '{order_id_input}' is being prepared")
        menu.restaurant()

    @classmethod
    def update_fu(cls):
        # updates the db table menu changing available from TRUE to FALSE or FALSE to TRUE
        choice_input = input("Activate or Deactivate Item: ").lower()
        if choice_input == "deactivate":
            item_id_input = input("Enter Food ID: ")
            query2 = """
            SELECT item_name
            FROM menu
            WHERE item_id = %s
            """
            cls.cursor.execute(query2, (item_id_input,))
            result = cls.cursor.fetchone()

            if result:
                item_name = result[0]

            query = """
            UPDATE menu
            SET available = FALSE
            WHERE item_id = %s
            """

            cls.cursor.execute(query, (item_id_input,))
            cls.conn.commit()
            print(
                f"The food item '{item_name}' is not available and has been removed from the menu\n"
            )
            menu.restaurant()
        elif choice_input == "activate":
            item_id_input = input("Enter Food ID: ")
            query2 = """
            SELECT item_name
            FROM menu
            WHERE item_id = %s
            """
            cls.cursor.execute(query2, (item_id_input,))
            result = cls.cursor.fetchone()

            if result:
                item_name = result[0]

            query = """
            UPDATE menu
            SET available = TRUE
            WHERE item_id = %s
            """

            cls.cursor.execute(query, (item_id_input,))
            cls.conn.commit()
            print(
                f"The food item '{item_name}' is now available and has been added to the menu\n"
            )
            menu.restaurant()

    @classmethod
    def update_re(cls):
        # updates the db table orders changing order_ready from FALSE to TRUE
        order_id_input = input("Enter Order ID: ")
        query = f"""
        UPDATE Orders
        SET order_ready = TRUE
        WHERE order_id = '{order_id_input}'
        """
        cls.cursor.execute(query)
        cls.conn.commit()
        print(f"The food for Order ID '{order_id_input}' is ready for the customer")
        menu.restaurant()

    @classmethod
    def update_de(cls):
        # updates the db table orders changing order_delivered from FALSE to TRUE
        order_id_input = input("Enter Order ID: ")
        query = f"""
        UPDATE Orders
        SET order_delivered = TRUE
        WHERE order_id = '{order_id_input}'
        """
        cls.cursor.execute(query)
        cls.conn.commit()
        print(
            f"The food for Order ID '{order_id_input}' has been delivered successfully"
        )
        menu.restaurant()

    def close_connection(cls):
        cls.conn.close()
