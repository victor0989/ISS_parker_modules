with Ada.Text_IO; use Ada.Text_IO;

package body Ethernet_Astronaut is

   Connected : Boolean := False;

   procedure Init_Communication is
   begin
      Connected := True;
      Put_Line("Ethernet communication initialized.");
   end Init_Communication;

   procedure Send_Message(Msg : String) is
   begin
      if Connected then
         Put_Line("Sending: " & Msg);
      else
         Put_Line("Not connected. Can't send message.");
      end if;
   end Send_Message;

   function Receive_Message return String is
   begin
      if Connected then
         return "Message received.";
      else
         return "No connection.";
      end if;
   end Receive_Message;

   function Is_Connected return Boolean is
   begin
      return Connected;
   end Is_Connected;

end Ethernet_Astronaut;
