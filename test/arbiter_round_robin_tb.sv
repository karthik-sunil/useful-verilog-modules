module arbiter_round_robin_tb();

localparam N = 4; 

logic clk;
logic rst_n;
logic [N-1:0] req;
logic [N-1:0] grant;

localparam CLOCK_PERIOD = 10;

arbiter_round_robin #(
    .N(N)
) dut (
    .clk(clk),
    .rst_n(rst_n),
    .req  (req),
    .grant(grant)
);

always begin
    clk = ~clk;
    #(CLOCK_PERIOD/2);
end

initial begin
    clk = 0; 
    rst_n = 0;
    req = 0;

    @(negedge clk);

    rst_n = 1; 

    // @(negedge clk);

    for(int i = 0; i<2**N; i++) begin
        req = i;
        
        @(negedge clk);
        // $display("req=%b, req_masked=%b, grant_raw=%b, grant=%b, mask=%b", req,dut.req_masked,dut.gnt_raw,grant,dut.mask);
        $display("req=%b, grant=%b, mask=%b",req,grant,dut.mask);
        
    end
    
    #100;
    $finish;
end

endmodule