N1 N1 NoLimit NULL 1 Normal
N2 N2 NoLimit N1 2 NormalOwner
N3 N3 NoLimit N1,N2 3 Normal
C1 C1 NoLimit N3,N4 4 CoreInternal
C2 C2 NoLimit C1 5 Core
N4 N4 NoLimit N1 6 Normal
N5 N5 NoLimit N4,C3 7 Normal
N6 N6 NoLimit N5 8 Normal
C3 C3 NoLimit C1 9 CoreDelegate