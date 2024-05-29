-- Drop the previous trigger if it exists
DROP TRIGGER IF EXISTS orders_update_modified ON orders;

-- Create a function to update the modified column - orders
CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.modified = CURRENT_TIMESTAMP; -- Set the modified column to the current timestamp
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger to call the function after insert or update on the orders table
CREATE TRIGGER orders_update_modified
BEFORE INSERT OR UPDATE
ON orders
FOR EACH ROW
EXECUTE FUNCTION update_modified_column();


-- Create a trigger to call the function after insert or update on the menu table
CREATE TRIGGER menu_update_modified
BEFORE INSERT OR UPDATE
ON menu
FOR EACH ROW
EXECUTE FUNCTION update_modified_column();

-- Create a trigger to call the function after insert or update on the waiters table
CREATE TRIGGER menu_update_modified
BEFORE INSERT OR UPDATE
ON waiters
FOR EACH ROW
EXECUTE FUNCTION update_modified_column();

-- Create a trigger to call the function after insert or update on the customers table
CREATE TRIGGER menu_update_modified
BEFORE INSERT OR UPDATE
ON customers
FOR EACH ROW
EXECUTE FUNCTION update_modified_column();

-- Create a trigger to call the function after insert or update on the waitlist table
CREATE TRIGGER menu_update_modified
BEFORE INSERT OR UPDATE
ON waitlist
FOR EACH ROW
EXECUTE FUNCTION update_modified_column();