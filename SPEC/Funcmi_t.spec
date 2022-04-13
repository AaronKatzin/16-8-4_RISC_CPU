<external_specifications>
    <functional_specifications>
        <declarations>
            <port name="dma" width="1" direction="in" />
            <port name="ext_adr" width="16" direction="in" />
            <port name="ext_in" width="16" direction="out" />
            <port name="ext_out" width="16" direction="in" />
            <port name="ext_rdwr" width="1" direction="in" />
            <port name="fgi" width="1" direction="in" />
            <port name="fgi_reset" width="1" direction="out" />
            <port name="fgo" width="1" direction="in" />
            <port name="fgo_reset" width="1" direction="out" />
            <port name="inpr" width="16" direction="in" />
            <port name="m" width="1" direction="in" />
            <port name="outr" width="16" direction="out" />
            <port name="s" width="1" direction="in" />
            <signal name="bor" width="16" size="16" />
            <signal name="br" width="16" />
            <signal name="br1" width="16" />
            <signal name="ien" width="1" />
            <signal name="ir1" width="16" />
            <signal name="ir2" width="16" />
            <signal name="m0" width="8" size="65536" />
            <signal name="m1" width="4" size="65536" />
            <signal name="mac" width="16" />
            <signal name="pc" width="16" />
            <signal name="r" width="1" />
            <signal name="ralu" width="16" />
            <signal name="zf" width="1" />
            <variable name="bor_adr" width="4" />
            <variable name="m0_adr" width="16" />
            <variable name="m1_adr" width="16" />
            <signal name="tempReg16_1" width="16" />
            <signal name="alu16_1_ctr" width="4" />
            <signal name="alu16_1_in1" width="16" />
            <signal name="alu16_1_in2" width="16" />
            <signal name="alu16_1_out" width="16" />
        </declarations>
        <functions>
            <func name="alu">
                <param name="alu_inp1" width="16" />
                <param name="alu_inp2" width="16" />
                <param name="alu_ctr" width="5" />
                <param name="alu_outp" width="16" />
                <param name="alu_z" width="1" />
            </func>
        </functions>
        <required_libraries>
            <vhdl>
                <library name="my_package" />
            </vhdl>
        </required_libraries>
    </functional_specifications>
</external_specifications>
