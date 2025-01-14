module arbiter_round_robin #(
    parameter N = 4
)(
    input logic clk,
    input logic rst_n,
    input logic [N-1:0] req,
    output logic [N-1:0] grant
);

logic [N-1:0] gnt_masked;
logic [N-1:0] gnt_raw;

logic [N-1:0] req_masked; 
logic [N-1:0] gnt_out; 

logic [N-1:0] mask;

assign req_masked = req & mask;

// Raw priority arbiter
arbiter #(
    .N(N)
) raw_priority (
    .req  (req),
    .grant(gnt_raw)
);

// Masked priority arbiter
arbiter #(
    .N(N)
) masked_priority (
    .req  (req_masked),
    .grant(gnt_masked)
);

// Mask generation logic - Detect leading 1 in grant and mask out higher priority bits
assign mask[N-1] = 1'b0;
genvar i;
generate
    for(i=N-1; i>0; i=i-1) begin
        assign mask[i-1] = mask[i] | gnt_ff[i];
    end
endgenerate



// If masked grant is 0, assign unmasked grant
assign gnt_out = (|(gnt_masked) == 1'b0) ? gnt_raw : gnt_masked;

// Register to hold the grant
logic [N-1:0] gnt_ff;

always_ff @(posedge clk) begin
    if(~rst_n) begin
        gnt_ff <= 0;
    end
    else begin
        gnt_ff <= gnt_out;
    end
end

assign grant = gnt_ff;

endmodule
