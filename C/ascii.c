//

#include <stdio.h>

void main()
{
	int i;
	
	for (i=0; i < 256; i++)
	{
		printf("%d: %c\n", (int)i, (char)i);
	}
}