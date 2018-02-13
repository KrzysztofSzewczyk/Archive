#include <stdio.h>

const long RAND_MAX = 5000;
long seed,amount;

int main(int argc, char* *argv) {
	if(argc!=2) {
		puts("Randgen: Ussage\nrandgen [base]\nWhere [base] is file to be used as random number base.");
	} else {
		FILE*f=fopen(argv[1],"r");
		while(!feof(f)) {
			fread(&seed,sizeof(long),1,f);
			for(amount=0;amount<RAND_MAX;amount++) {
				seed=1103515245*seed+12345;
				printf("%d ",seed);
			}
		}
		fclose(f);
	}
	return 0;
}
