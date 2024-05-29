import psycopg2
from tabulate import tabulate
import menu


class WaitListChoices:
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
    def show_list(cls):
        query = """
        SELECT waitlist_id AS Waitlist_ID, CONCAT(first_name, ' ', last_name) AS Name, email AS Email, phone_number AS Phone_Number
        FROM Waitlist 
        ORDER BY modified DESC
        """
        cls.cursor.execute(query)
        results = cls.cursor.fetchall()
        if results:
            headers = [desc[0].upper() for desc in cls.cursor.description]
            print(tabulate(results, headers=headers, tablefmt="fancy_grid"))
        menu.waitlist()

    @classmethod
    def insert(cls):
        fn_choice = input("Enter customer's first name: ")
        ln_choice = input("Enter customer's last name: ")
        em_choice = input("Enter customer's email address: ")
        pn_choice = input("Enter customer's telephone number: ")
        query = """
        INSERT INTO Waitlist (first_name, last_name, email, phone_number)
        VALUES (%s, %s, %s, %s);
        """
        cls.cursor.execute(
            query,
            (
                fn_choice,
                ln_choice,
                em_choice,
                pn_choice,
            ),
        )
        cls.conn.commit()
        print(f"You have been successfully added to the waitlist!")
        menu.waitlist()

    @classmethod
    def update(cls):
        wl_id = input("Enter the Waitlist ID: ")
        query_update = f"""
        UPDATE Waitlist
        SET seated = TRUE
        WHERE waitlist_id = '{wl_id}'
        """
        cls.cursor.execute(query_update, (wl_id,))

        query_insert = f"""
        INSERT INTO Customers (first_name, last_name, email, phone_number)
        SELECT first_name, last_name, email, phone_number
        FROM waitlist
        WHERE waitlist_id = '{wl_id}'
        """
        cls.cursor.execute(query_insert, (wl_id,))

        query_delete = f"""
        DELETE FROM Waitlist
        WHERE waitlist_id = '{wl_id}'
        """
        cls.cursor.execute(query_delete, (wl_id,))
        cls.conn.commit()
        print("The customer has been seated")
        menu.waitlist()

    def close_connection(cls):
        cls.conn.close()
