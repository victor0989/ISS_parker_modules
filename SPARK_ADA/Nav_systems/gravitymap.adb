with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

package body GravityMap is

   type Vector3D is record
      X, Y, Z : Float;
   end record;

   type Gravity_Zone is record
      Center : Vector3D;
      Radius : Float;
      Intensity : Float;
   end record;

   Gravity_Zones : array (1 .. 10) of Gravity_Zone;
   Zone_Count : Natural := 0;

   procedure Add_Gravity_Zone(Zone : Gravity_Zone) is
   begin
      if Zone_Count < Gravity_Zones'Length then
         Zone_Count := Zone_Count + 1;
         Gravity_Zones(Zone_Count) := Zone;
         Put_Line("Gravity zone added.");
      else
         Put_Line("No space for more gravity zones.");
      end if;
   end Add_Gravity_Zone;

   procedure Clear_Gravity_Zones is
   begin
      Zone_Count := 0;
      Put_Line("Gravity zones cleared.");
   end Clear_Gravity_Zones;

   function Vector_Magnitude(V : Vector3D) return Float is
   begin
      return Float'Math.Sqrt(V.X*V.X + V.Y*V.Y + V.Z*V.Z);
   end Vector_Magnitude;

   function Grav_Intensity_At(Pos : Vector3D) return Float is
      Distance : Float;
      Intensity_Sum : Float := 0.0;
   begin
      for I in 1 .. Zone_Count loop
         Distance := Vector_Magnitude(
            (Pos.X - Gravity_Zones(I).Center.X,
             Pos.Y - Gravity_Zones(I).Center.Y,
             Pos.Z - Gravity_Zones(I).Center.Z));
         if Distance < Gravity_Zones(I).Radius then
            Intensity_Sum := Intensity_Sum + Gravity_Zones(I).Intensity;
         end if;
      end loop;
      return Intensity_Sum;
   end Grav_Intensity_At;

   function Check_Grav_Alert(Pos : Vector3D) return Boolean is
      Threshold : constant Float := 5.0;  -- ejemplo
   begin
      return Grav_Intensity_At(Pos) > Threshold;
   end Check_Grav_Alert;

end GravityMap;
