module arbiter #(
    parameter N = 4
)(
    input logic [N-1:0] req,
    output logic [N-1:0] grant
);

logic [N-1:0] mask; // mask for the request

// MSB has highest priority
assign mask[N-1] = 1'b0;

genvar i;
generate 
for(i=N-1; i>0; i=i-1) begin
    assign mask[i-1] = mask[i] | req[i];
end
endgenerate

assign grant = ~mask & req;


endmodule