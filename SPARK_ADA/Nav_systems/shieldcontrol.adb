with Ada.Text_IO; use Ada.Text_IO;

package body ShieldControl is

   Max_Units : constant Integer := 3;
   Shield_States : array(1 .. Max_Units) of Shield_State := (others => Retracted);

   procedure Deploy_Shield(Unit_ID : Integer) is
   begin
      if Unit_ID <= Max_Units then
         Shield_States(Unit_ID) := Deploying;
         Put_Line("Deploying shield unit " & Integer'Image(Unit_ID));
         Shield_States(Unit_ID) := Deployed;
      else
         Put_Line("Invalid shield unit.");
      end if;
   end Deploy_Shield;

   procedure Retract_Shield(Unit_ID : Integer) is
   begin
      if Unit_ID <= Max_Units then
         Shield_States(Unit_ID) := Retracted;
         Put_Line("Retracting shield unit " & Integer'Image(Unit_ID));
      else
         Put_Line("Invalid shield unit.");
      end if;
   end Retract_Shield;

   procedure Reinforce_Shield(Unit_ID : Integer) is
   begin
      if Unit_ID <= Max_Units then
         Shield_States(Unit_ID) := Reinforced;
         Put_Line("Reinforcing shield unit " & Integer'Image(Unit_ID));
      else
         Put_Line("Invalid shield unit.");
      end if;
   end Reinforce_Shield;

   procedure Report_Shield_Status(Unit_ID : Integer) is
   begin
      if Unit_ID <= Max_Units then
         Put_Line("Shield unit " & Integer'Image(Unit_ID) & " state: " &
                  Shield_State'Image(Shield_States(Unit_ID)));
      else
         Put_Line("Invalid shield unit.");
      end if;
   end Report_Shield_Status;

   function Get_Shield_State(Unit_ID : Integer) return Shield_State is
   begin
      if Unit_ID <= Max_Units then
         return Shield_States(Unit_ID);
      else
         return Retracted;
      end if;
   end Get_Shield_State;

end ShieldControl;
