// ==========================================================================
// --------------------------------------------------------------------------
// Converting list files into equates files
// --------------------------------------------------------------------------

#include <stdio.h>
#include <windows.h>

// ==========================================================================
// --------------------------------------------------------------------------
// Modifying a channel
// --------------------------------------------------------------------------

void ModChannel (int *Touch, char *Memory, int ChannelLoc, int &MemorySize)

{
	int TouchLoc;
	for (TouchLoc = 0x00; TouchLoc < MemorySize; TouchLoc++)
	{
		Touch [TouchLoc] = 0x00;
	}
	int MemoryLoc = MemorySize;
	u_char Byte;
	u_char LastNote = 0x00;
	bool Exit = FALSE;
	int Stack [0x10];
	int StackPos = 0x10;

	int JumpList [0x1000];
	int JumpListLoc, JumpListSize = 0x00;
	for ( ; Exit == FALSE; )
	{
		Byte = Memory [ChannelLoc];
		Touch [ChannelLoc++] = MemoryLoc;
		if (Byte >= 0x00 && Byte <= 0x80)
		{
			Memory [MemoryLoc++] = Byte;
		}
		else if (Byte >= 0x81 && Byte <= 0xDF)
		{
		//	if (LastNote != Byte)
			{
				LastNote = Byte;
				Memory [MemoryLoc++] = 0xF5;		// PCM select flag
				Memory [MemoryLoc++] = Byte - 0x81;	// PCM select ID
			}
			if (Byte == 0x81)
			{
				Memory [MemoryLoc++] = 0xAC;		// Lower note for kick
			}
			else
			{
				Memory [MemoryLoc++] = 0xB1;		// Neutral note for everything else
			}
		}
		else
		{
			switch (Byte)
			{
				case 0xE0:
				case 0xE1:
				case 0xE2:
				case 0xE5:
				case 0xE6:
				case 0xE8:
				case 0xE9:
				case 0xEA:
				case 0xEB:
				case 0xEC:
				case 0xEF:
				case 0xF3:
				case 0xF5:
				{
					Memory [MemoryLoc++] = Byte;
					Touch [ChannelLoc] = MemoryLoc;
					Memory [MemoryLoc++] = Memory [ChannelLoc++];
				}
				break;
				case 0xE7:
				case 0xED:
				case 0xF1:
				case 0xF4:
				case 0xF9:
				{
					Memory [MemoryLoc++] = Byte;
				}
				break;
				case 0xF0:
				{
					Memory [MemoryLoc++] = Byte;
					Touch [ChannelLoc] = MemoryLoc;
					Memory [MemoryLoc++] = Memory [ChannelLoc++];
					Touch [ChannelLoc] = MemoryLoc;
					Memory [MemoryLoc++] = Memory [ChannelLoc++];
					Touch [ChannelLoc] = MemoryLoc;
					Memory [MemoryLoc++] = Memory [ChannelLoc++];
					Touch [ChannelLoc] = MemoryLoc;
					Memory [MemoryLoc++] = Memory [ChannelLoc++];
				}
				break;
				case 0xE4:
				case 0xEE:
				case 0xF2:
				{
					Memory [MemoryLoc++] = Byte;
					Exit = TRUE;
				}
				break;
				case 0xF6:
				{
					int Value = Memory [ChannelLoc++] << 0x08;
					Value |= Memory [ChannelLoc] & 0xFF;
					Value += ChannelLoc;


					for (JumpListLoc = 0x00; JumpListLoc < JumpListSize; JumpListLoc++)
					{
						if (ChannelLoc == JumpList [JumpListLoc])
						{
							break;
						}
					}
					if (JumpListLoc == JumpListSize)
					{
						JumpList [JumpListSize++] = ChannelLoc;
					}
					if (Touch [Value] == 0x00 || JumpListLoc < (JumpListSize - 0x01))
					{
						Touch [ChannelLoc - 0x01] = -0x01;
						Touch [ChannelLoc] = -0x01;
						ChannelLoc = Value;
						break;
					}
					Memory [MemoryLoc++] = Byte;
					Touch [ChannelLoc - 0x01] = MemoryLoc;
					Touch [ChannelLoc] = MemoryLoc + 0x01;
					ChannelLoc = Value;
					Value = Touch [ChannelLoc] - (MemoryLoc + 0x01);
					Memory [MemoryLoc++] = Value >> 0x08;
					Memory [MemoryLoc++] = Value & 0xFF;
					Exit = TRUE;
				}
				break;
				case 0xF7:
				{
					Memory [MemoryLoc++] = Byte;
					Touch [ChannelLoc] = MemoryLoc;
					Touch [ChannelLoc + 0x01] = MemoryLoc + 0x01;
					Touch [ChannelLoc + 0x02] = MemoryLoc + 0x02;
					Touch [ChannelLoc + 0x03] = MemoryLoc + 0x03;
					Memory [MemoryLoc++] = Memory [ChannelLoc++];
					Memory [MemoryLoc++] = Memory [ChannelLoc++];

					int Value = Memory [ChannelLoc++] << 0x08;
					Value |= Memory [ChannelLoc] & 0xFF;
					Value += ChannelLoc++;
					Value = Touch [Value] - (MemoryLoc + 0x01);
					Memory [MemoryLoc++] = Value >> 0x08;
					Memory [MemoryLoc++] = Value & 0xFF;
				}
				break;
				case 0xF8:
				{
					int Value = Memory [ChannelLoc++] << 0x08;
					Value |= Memory [ChannelLoc] & 0xFF;
					Value += ChannelLoc;
					Touch [ChannelLoc - 0x01] = -0x01;
					Touch [ChannelLoc] = -0x01;
					Stack [--StackPos] = ChannelLoc + 0x01;
					ChannelLoc = Value;
				}
				break;
				case 0xE3:
				{
					ChannelLoc = Stack [StackPos++];
				}
				break;
			}
		}
	}
	MemorySize = MemoryLoc;
}

// ==========================================================================
// --------------------------------------------------------------------------
// Main Routine
// --------------------------------------------------------------------------

int main (int ArgNumber, char **ArgList, char **EnvList)

{
	printf ("ModDAC - by MarkeyJester\n\n");
	if (ArgNumber <= 0x01)
	{
		printf (" -> Arguements: ModDAC.exe music81.bin music82.bin music83.bin etc...\n\n");
		printf ("    This tool will modify the DAC/PCM channels (make sure you've passed\n");
		printf ("    it through AddDAC.exe first!)\n");
		printf ("\nPress enter key to exit...\n");
		fflush (stdin);
		getchar ( );
		return (0x00);
	}
	int ArgCount;
	for (ArgCount = 0x01; ArgCount < ArgNumber; ArgCount++)
	{
		printf (" -> %s\n", ArgList [ArgCount]);
		FILE *File = fopen (ArgList [ArgCount], "rb");
		if (File == NULL)
		{
			printf ("    Error; could not open the file...\n");
			continue;
		}
		fseek (File, 0x00, SEEK_END);
		int MemorySize = ftell (File);
		char *Memory = (char*) malloc (MemorySize * 0x08);
		int *Touch = (int*) malloc ((MemorySize * 0x08) * sizeof (int));
		if (Memory == NULL || Touch == NULL)
		{
			printf ("    Error; could not allocate enough memory...\n");
			continue;
		}
		rewind (File);
		int MemoryLoc;
		for (MemoryLoc = 0x00; MemoryLoc < MemorySize; MemoryLoc++)
		{
			Memory [MemoryLoc] = fgetc (File);
		}
		fclose (File);

		MemoryLoc = Memory [0x06] << 0x08;
		MemoryLoc |= Memory [0x07] & 0xFF;
		Memory [0x06] = MemorySize >> 0x08;
		Memory [0x07] = MemorySize;
		ModChannel (Touch, Memory, MemoryLoc, MemorySize);
		MemoryLoc = Memory [0x0A] << 0x08;
		MemoryLoc |= Memory [0x0B] & 0xFF;
		Memory [0x0A] = MemorySize >> 0x08;
		Memory [0x0B] = MemorySize;
		ModChannel (Touch, Memory, MemoryLoc, MemorySize);

		if ((File = fopen (ArgList [ArgCount], "wb")) == NULL)
		{
			free (Memory); Memory = NULL;
			free (Touch); Touch = NULL;
			printf ("    Error; could not open the file...\n");
			continue;
		}
		for (MemoryLoc = 0x00; MemoryLoc < MemorySize; MemoryLoc++)
		{
			fputc (Memory [MemoryLoc], File);
		}
		fclose (File);
		free (Memory); Memory = NULL;
		free (Touch); Touch = NULL;
	}
	printf ("\nPress enter key to exit...\n");
	fflush (stdin);
	getchar ( );
	return (0x00);
}

// ==========================================================================
