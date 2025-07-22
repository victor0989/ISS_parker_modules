
-- assistdrones.ads
with GravityMap;

package AssistDrones is

   type Drone_Status is (Idle, En_Ruta, Acoplando, Reparando, Retornando);

   type Vector3D is record
      X, Y, Z : Float;
   end record;

   type Drone_Info is record
      ID       : Integer;
      Status   : Drone_Status := Idle;
      Position : Vector3D := (0.0, 0.0, 0.0);
   end record;

   procedure Deploy_Drone(ID : Integer; Destino : Vector3D);
   procedure Abort_Mission(ID : Integer);
   function Get_Drone_Status(ID : Integer) return Drone_Status;
   procedure Request_Shield_Reinforcement(Pos : Vector3D);

end AssistDrones;
