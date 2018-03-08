PRAGMA foreign_keys = ON;
drop TRIGGER if exists advance_current_time;
create trigger advance_current_time
before update on CurrentTime
when NEW.CurrentTime.time < OLD.CurrentTime.time
begin
	select
  	raise(abort,'date time can only advance forward')
 	end;
end;
