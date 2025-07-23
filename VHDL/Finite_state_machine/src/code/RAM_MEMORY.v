//******************** RAM_MEMORY ********************
// 
// This module describes the main memory.
// 
// The read and write are separate channels.
// The write occurs on the rising edge of the clock.
// The read occurs on the rising edge of the clock.
// 
// All accesses are in blocks of 64 bits. An update to an
// individual byte will require a READ followed by a WRITE.
// 
// The low-order 3 bits of the address are ignored.
// 

module RAM_MEMORY (
    input  wire          clock,
    input  wire          clock_enable,
    input  wire [35:0]   addr,
    output reg [63:0]    data_out,
         
    input  wire          write_enab,
    input  wire [63:0]   data_in
);

    // Definición de parámetros locales
    localparam RAM_START  = 36'h0_0000_0000;
    localparam RAM_MEMORY_SIZE_IN_DWORDS = 32768;    // At 8 bytes per, this is 256 KiBytes.
         
    // Definición de la memoria
    reg [63:0] mem [0:RAM_MEMORY_SIZE_IN_DWORDS-1];

    always @(posedge clock) begin
        if (clock_enable) begin
            if (write_enab) begin
                mem[addr[35:3]] <= data_in;     // Ignorar 3 bits LSB de la dirección
            end
            data_out <= mem[addr[35:3]];        // Ignorar 3 bits LSB de la dirección
        end
    end

endmodule  //  RAM_MEMORY

