
-- assistdrones.adb
with Ada.Text_IO; use Ada.Text_IO;
package body AssistDrones is

   Max_Drones : constant Integer := 5;
   Drones     : array(1 .. Max_Drones) of Drone_Info;
   Drone_Count : Natural := 0;

   procedure Deploy_Drone(ID : Integer; Destino : Vector3D) is
   begin
      Put_Line("Deploying drone " & Integer'Image(ID));
      if ID <= Max_Drones then
         Drones(ID).Position := Destino;
         Drones(ID).Status := En_Ruta;
      else
         Put_Line("Invalid drone ID");
      end if;
   end Deploy_Drone;

   procedure Abort_Mission(ID : Integer) is
   begin
      if ID <= Max_Drones then
         Drones(ID).Status := Retornando;
         Put_Line("Drone " & Integer'Image(ID) & " aborting mission.");
      else
         Put_Line("Invalid drone ID");
      end if;
   end Abort_Mission;

   function Get_Drone_Status(ID : Integer) return Drone_Status is
   begin
      if ID <= Max_Drones then
         return Drones(ID).Status;
      else
         return Idle;
      end if;
   end Get_Drone_Status;

   procedure Request_Shield_Reinforcement(Pos : Vector3D) is
   begin
      Put_Line("Requesting shield reinforcement at position (" &
         Float'Image(Pos.X) & "," &
         Float'Image(Pos.Y) & "," &
         Float'Image(Pos.Z) & ")");
   end Request_Shield_Reinforcement;

end AssistDrones;
