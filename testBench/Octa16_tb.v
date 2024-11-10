module Octa16_tb;
    reg clk, reset, Ext_MemWrite;
    reg [15:0] Ext_WriteData;
    reg [3:0] Ext_DataAdr;
    reg [3:0] DataAddr;
    wire [7:0] dIn;
    
    Octa16 DUT (
        .clk(clk),
        .reset(reset),
        .Ext_MemWrite(Ext_MemWrite),
        .Ext_WriteData(Ext_WriteData),
        .Ext_DataAdr(Ext_DataAdr),
        .DataAddr(DataAddr),
        .dIn(dIn)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Test sequence
    initial begin
        // Initialize signals
        reset = 1;
        Ext_MemWrite = 0;
        Ext_WriteData = 16'h0000;
        Ext_DataAdr = 4'h0;
        DataAddr = 4'h0;
        
        // Apply reset
        #10 reset = 0;
        
        // Write data to memory
        #10 Ext_MemWrite = 1; Ext_WriteData = 16'hABCD; Ext_DataAdr = 4'h0;
        #10 Ext_MemWrite = 1; Ext_WriteData = 16'h1234; Ext_DataAdr = 4'h1;
        #10 Ext_MemWrite = 1; Ext_WriteData = 16'h5678; Ext_DataAdr = 4'h2;
        #10 Ext_MemWrite = 1; Ext_WriteData = 16'h9ABC; Ext_DataAdr = 4'h3;
        
        // Stop writing to memory
        #10 Ext_MemWrite = 0;
        
        // Read data back from memory
        #10 DataAddr = 4'h0;
        #10 DataAddr = 4'h1;
        #10 DataAddr = 4'h2;
        #10 DataAddr = 4'h3;
        
        // Finish the simulation
        #20 $finish;
    end

    // Monitor changes
    initial begin
        $monitor("Time=%0t | clk=%b | reset=%b | Ext_MemWrite=%b | Ext_WriteData=%h | Ext_DataAdr=%h | DataAddr=%h | dIn=%h",
                  $time, clk, reset, Ext_MemWrite, Ext_WriteData, Ext_DataAdr, DataAddr, dIn);
    end
endmodule

