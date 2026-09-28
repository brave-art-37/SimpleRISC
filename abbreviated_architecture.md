# SimpleRISC architecture

```mermaid
flowchart TB

    %% node index
    %% PCM = Program Counter Manager
    %% IM = Instruction Memory
    %% CU = Control Unit
    %% F1 = First Operand MUX
    %% F2 = Second Operand MUX
    %% RF = Register File
    %% IBT = Immediate / Branch Target
    %% ALU = ALU
    %% BU = Branch Unit
    %% MAU = Memory Access Unit
    %% DM = Data Memory
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
    %% rd = destination register
    %% rs1 = first source register
    %% rs2 = second source register
    %% addr = address port
    %% data = data port
    %% wb = write back
    %% en = enable port
    %% call = call

    PCM[PCM]
    IM[IM]
    IF/OF[IF/OF]

    CU[CU]
    F1[F1]
    F2[F2]
    RF[RF]
    IBT[IBT]
    OF/EX[OF/EX]

    ALU[ALU]
    BU[BU]
    EX/MA[EX/MA]

    MAU[MAU]
    DM[DM]
    MA/RW[MA/RW]

    WAR[WAR]
    WDM[WDM]
    RAR[RAR]

    %% IF
    PCM -->|pc| IM
    PCM -->|pc| IF/OF
    IM -->|i| IF/OF

    %% OF
    IF/OF -->|i| CU
    IF/OF --> |"rs1(i)"| F1
    IF/OF --> |"rd(i),rs2(i)"| F2
    CU -->|ret| F1
    CU -->|st| F2
    RAR --> F1
    F1 -->|r1| RF
    F2 -->|r2| RF
    CU -->|c| OF/EX
    RF -->|a,b| OF/EX
    IF/OF -->|pc,i| IBT
    IBT -->|bt,imm| OF/EX
    IF/OF -->|pc,i| OF/EX

    %% EX
    OF/EX -->|"a,b,imm,ac(c)"| ALU
    ALU -->|r| EX/MA
    ALU -->|f| BU
    OF/EF -->|"bt,a,ret(c),beq(c),bgt(c),ub(c)"| BU
    BU -->|taken,bpc| PCM
    OF/EX -->|pc,i,b,c| EX/MA

    %% MA
    EX/MA -->|"r,b,ld(c),st(c)"| MAU
    MAU <-->|ma,md| DM
    MAU -->|ldr| MA/RW
    EX/MA -->|pc,r,i,c| MA/RW

    %% RW
    MA/RW -->|"rd(i),call(c)"| WAR
    RAR --> |ra| WAR
    WAR -->|addr| RF
    MA/RW -->|"pc,ldr,r,ld(c),call(c)"| WDM
    WDM -->|data| RF
    MA/RW -->|"wb(c),en"| RF
