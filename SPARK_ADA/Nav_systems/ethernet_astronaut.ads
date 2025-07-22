package Ethernet_Astronaut is

   procedure Init_Communication;
   procedure Send_Message(Msg : String);
   function Receive_Message return String;
   function Is_Connected return Boolean;

end Ethernet_Astronaut;
