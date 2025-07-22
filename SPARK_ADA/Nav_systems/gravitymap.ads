package GravityMap is

   type Vector3D is record
      X, Y, Z : Float;
   end record;

   type Gravity_Zone is record
      Center : Vector3D;
      Radius : Float;
      Intensity : Float; -- intensidad de anomalía gravitacional
   end record;

   procedure Add_Gravity_Zone(Zone : Gravity_Zone);
   procedure Clear_Gravity_Zones;
   function Check_Grav_Alert(Pos : Vector3D) return Boolean;

   -- Retorna la intensidad de la anomalía en la posición
   function Grav_Intensity_At(Pos : Vector3D) return Float;

end GravityMap;
