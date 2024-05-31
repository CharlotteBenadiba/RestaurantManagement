CREATE OR REPLACE FUNCTION update_deleted_column()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.deleted IS DISTINCT FROM OLD.deleted THEN
        NEW.deleted = CURRENT_TIMESTAMP; -- Set the deleted column to the current timestamp
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger to call the function before update on the Customers table
CREATE TRIGGER customers_update_deleted
BEFORE UPDATE OF deleted
ON Customers
FOR EACH ROW
EXECUTE FUNCTION update_deleted_column();
