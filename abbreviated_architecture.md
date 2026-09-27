# SimpleRISC architecture

```mermaid
flowchart TB

    %% node index
    %% PCM = Program Counter Manager
    %% IM = Instruction Memory
    %% IO = IF/OF
    %% CU = Control Unit
    %% F1 = First Operand MUX
    %% F2 = Second Operand MUX
    %% RF = Register File
    %% IBT = Immediate / Branch Target
    %% OE = OF/EX
    %% ALU = ALU
    %% BU = Branch Unit
    %% EM = EX/MA
    %% MAU = Memory Access Unit
    %% DM = Data Memory
    %% MW = MA/RW
    %% WAR = Write Address MUX
    %% WDM = Write Data MUX
    %% RAR = Return Address Register

    %% signal index
    %% pc = program counter
    %% i = instruction
    %% ret = return
    %% st = store
    %% r1 = first operand register
    %% r2 = second operand register
    %% c = control signals
    %% a = first operand
    %% b = second operand
    %% bt = branch target
    %% imm = immediate
    %% ac = ALU signals
    %% r = ALU result
    %% f = flags
    %% beq = branch equal
    %% bgt = branch greater
    %% ub = unconditional branch
    %% taken = branch taken
    %% bpc = branch program counter
    %% ld = load
    %% ma = memory address
    %% md = memory data
    %% ldr = load result
    %% d = destination register
    %% addr = address port
    %% data = data port
    %% wb = write back
    %% en = enable port
    %% call = call

    PCM[PCM]
    IM[IM]
    IO[IF/O]

    CU[CU]
    F1[F1]
    F2[F2]
    RF[RF]
    IBT[IBT]
    OE[O/E]

    ALU[ALU]
    BU[BU]
    EM[E/M]

    MAU[MAU]
    DM[DM]
    MW[M/W]

    WAR[WAR]
    WDM[WDM]
    RAR[RAR]

    %% IF
    PCM -->|pc| IM
    PCM -->|pc| IO
    IM -->|i| IO

    %% OF
    IO -->|i| CU
    CU -->|ret| F1
    CU -->|st| F2
    F1 -->|r1| RF
    F2 -->|r2| RF
    CU -->|c| OE
    RF -->|a,b| OE
    IBT -->|bt,imm| OE
    IO -->|pc,i| OE

    %% EX
    OE -->|"a,b,imm,ac(c)"| ALU
    ALU -->|r| EM
    ALU -->|f| BU
    OE -->|"bt,a,ret(c),beq(c),bgt(c),ub(c)"| BU
    BU -->|taken,bpc| PCM
    OE -->|pc,i,b,c| EM

    %% MA
    EM -->|"r,b,ld(c),st(c)"| MAU
    MAU <-->|ma,md| DM
    MAU -->|ldr| MW
    EM -->|pc,r,i,c| MW

    %% RW
    MW -->|"d(i),call(c)"| WAR
    RAR --> |ra| WAR
    WAR -->|addr| RF
    MW -->|"pc,ldr,r,ld(c),call(c)"| WDM
    WDM -->|data| RF
    MW -->|"wb(c),en"| RF