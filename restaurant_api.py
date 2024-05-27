import psycopg2
from tabulate import tabulate


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
        SELECT item_name AS Name, category AS Category, concat('$', price) AS Price FROM Menu WHERE available = TRUE
        ORDER BY  category DESC
        """
        cls.cursor.execute(query)
        results = cls.cursor.fetchall()
        if results:
            headers = [desc[0].upper() for desc in cls.cursor.description]
            print(tabulate(results, headers=headers, tablefmt="fancy_grid"))
        import menu

        menu.restaurant()

    # def insert():
    #     # inserts into the db table orders
    #     cu_choice = input("Enter Customer ID: ")
    #     wa_choice = input("Enter Waiter ID: ")
    #     fo_choice = input("What would you like to order today? ")
    #     query = f"""
    #     INSERT INTO orders (customer_id, waiter_id, items)
    #     VALUES ({cu_choice}, {wa_choice}, {fo_choice})
    #     """

    # def update():
    #     # updates a food in db table orders
    #     choice = input("What would you like to change FOOD to? ")
    #     print(f"Your order has been changed to {choice}")

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
        # updates order_complete column in orders table from FALSE to TRUE
        order_id_input = input("Enter Order ID: ")
        query = f"""
        UPDATE Orders
        SET order_complete = TRUE
        WHERE order_id = '{order_id_input}'
        """
        cls.cursor.execute(query)
        print("You have paid for your order successfully!")

    def close_connection(cls):
        cls.conn.close()
