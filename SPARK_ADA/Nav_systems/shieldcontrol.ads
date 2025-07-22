package ShieldControl is

   type Shield_State is (Retracted, Deploying, Deployed, Reinforced, Damaged);

   procedure Deploy_Shield(Unit_ID : Integer);
   procedure Retract_Shield(Unit_ID : Integer);
   procedure Reinforce_Shield(Unit_ID : Integer);
   procedure Report_Shield_Status(Unit_ID : Integer);

   function Get_Shield_State(Unit_ID : Integer) return Shield_State;

end ShieldControl;
