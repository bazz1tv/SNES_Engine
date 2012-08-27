//

#include <stdio.h>

void main()
{
	printf("XLUT:\n");
	
	int i;
	for (i=0; i<256; i++)
	{
		printf(".DB \"%d", i);
		
		if (i < 10)
			printf("  \"\n");
		else if (i >= 10 && i < 100)
			printf(" \"\n");
		else printf("\"\n");
		
	}
	
	printf (".DB 0\n\n");
	
	printf("YLUT:\n");
	
	for (i=0; i<224; i++)
	{
		printf(".DB \"%d", i);
		
		if (i < 10)
			printf("  \"\n");
		else if (i >= 10 && i < 100)
			printf(" \"\n");
		else printf("\"\n");
		
	}
	
	printf (".DB 0\n\n");
	
}