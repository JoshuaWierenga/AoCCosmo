// clang-format off
#include "libc/inttypes.h"
#include "libc/runtime/runtime.h"
#include "libc/stdio/stdio.h"
#include "third_party/aoc/utilities/aocdatamanagement.h"
#include "third_party/aoc/utilities/macros.h"

enum RPSOption
{
    Rock = 1,
    Paper = 2,
    Scissors = 3
};

enum RPSResult
{
    Lost,
    Draw = 3,
    Won = 6
};

enum RPSOption ParseOpponent(char opponentChar)
{
    if (opponentChar < 'A' || opponentChar > 'C')
    {
        perror("Unable to parse input file");
        exit(1);
    }
    
    // A = 65, B = 66, C = 67
    return opponentChar - ('A' - 1);
}

enum RPSOption ParseYouPart1(char youChar)
{
    if (youChar < 'X' || youChar > 'Z')
    {
        perror("Unable to parse input file");
        exit(1);
    }
    
    // X = 88, Y =  89, Z = 90
    return youChar - ('X' - 1);
}

enum RPSResult ParseResultPart2(char resultChar)
{
    if (resultChar < 'X' || resultChar > 'Z')
    {
        perror("Unable to parse input file");
        exit(1);
    }
    
    // X = 88, Y =  89, Z = 90
    return 3 * (resultChar - 'X');
}

enum RPSResult PlayRoundPart1(enum RPSOption opponent, enum RPSOption you)
{
    // Rock Rock, Paper Paper, Scissors Scissors
    if (opponent == you)
    {
        return Draw;
    }
    
    int result = opponent - you;
    
    // Rock Scissors, Paper Rock, Scissors Rock
    if (result == -2 || result == 1)
    {
        return Lost;
    }
    
    // Rock Paper, Paper Scissors, Scissors Rock
    return Won;
}

enum RPSOption FindOptionPart2(enum RPSOption opponent, enum RPSResult result)
{
    return (result / 3 + opponent + 1) % 3 + 1;
}

uint_fast8_t DetermineRoundPoints(enum RPSOption you, enum RPSResult result)
{
    return you + result;
}

void task2()
{
    FILE* fp = faocdataopen(__FILE__);
    
    // Longest valid input is a char, a space, a char, a new line and the string terminator
    char chunk[5];
    
    uint_fast16_t scorePart1 = 0;
    uint_fast16_t scorePart2 = 0;
    
    startTesting();
    
    rewind(fp);
    scorePart1 = scorePart2 = 0;
    
    while (fgets(chunk, sizeof(chunk), fp) != NULL)
    {
        enum RPSOption opponent = ParseOpponent(chunk[0]);
        enum RPSOption youPart1 = ParseYouPart1(chunk[2]);
        enum RPSResult resultPart2 = ParseResultPart2(chunk[2]);
        if (chunk[1] != ' ' || chunk[3] != '\n')
        {
            perror("Unable to parse input file");
            exit(1); 
        }
        
        enum RPSResult resultPart1 = PlayRoundPart1(opponent, youPart1);
        enum RPSOption youPart2 = FindOptionPart2(opponent, resultPart2);
        
        scorePart1 += youPart1 + resultPart1;
        scorePart2 += youPart2 + resultPart2;
    }
    
    endTesting();
    fclose(fp);
    
    printf("Part 1: Score with guide giving response: %" PRIuFAST16 "\n", scorePart1);
    printf("Part 2: Score with guide giving outcome:  %" PRIuFAST16 "\n", scorePart2);
}
