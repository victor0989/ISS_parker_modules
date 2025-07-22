
package Thermal is

   type Vector3D is record
      X, Y, Z : Float;
   end record;

   -- Sensores f�sicos y ambientales
   function Read_Accelerometer return Vector3D;
   function Read_LIDAR return Float;                -- distancia al obst�culo m�s cercano
   function Read_Temperature return Float;
   function Read_Radiation_Level return Float;
   function Read_Proximity_Alert return Boolean;

end Thermal;
