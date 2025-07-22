package GravityMap is

   type Vector3D is record
      X, Y, Z : Float;
   end record;

   type Gravity_Zone is record
      Center : Vector3D;
      Radius : Float;
      Intensity : Float; -- intensidad de anomal�a gravitacional
   end record;

   procedure Add_Gravity_Zone(Zone : Gravity_Zone);
   procedure Clear_Gravity_Zones;
   function Check_Grav_Alert(Pos : Vector3D) return Boolean;

   -- Retorna la intensidad de la anomal�a en la posici�n
   function Grav_Intensity_At(Pos : Vector3D) return Float;

end GravityMap;
