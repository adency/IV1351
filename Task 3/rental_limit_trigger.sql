-- FUNCTION: public.instrument_rental_limit()

-- DROP FUNCTION IF EXISTS public.instrument_rental_limit();

CREATE OR REPLACE FUNCTION public.instrument_rental_limit()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    -- Count active rentals for the student
    IF (SELECT COUNT(*) 
        FROM rented_instrument 
        WHERE student_id = NEW.student_id AND rent_end IS NULL) >= 2 THEN
        RAISE EXCEPTION 'Student has already rented the maximum of 2 instruments';
    END IF;
    RETURN NEW;  -- Allow the insertion if the condition is not violated
END;
$BODY$;

ALTER FUNCTION public.instrument_rental_limit()
    OWNER TO postgres;
