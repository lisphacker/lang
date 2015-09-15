#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <time.h>

#define NBOOTS           500
#define NTRACES          2500
#define PRNG_STATE_SIZE  128                    \
    
int first_run[NBOOTS][NTRACES];
int second_run[NBOOTS][NTRACES];

void init(int rnd[NBOOTS][NTRACES], int num_threads) {
    if (num_threads > 0)
        omp_set_num_threads(num_threads);

#pragma omp parallel
    {
        int tid = omp_get_thread_num();

        struct random_data rng_state;
        bzero(&rng_state, sizeof(rng_state));
        char state_buf[PRNG_STATE_SIZE];

        //for (int i = 0; i < PRNG_STATE_SIZE; i++)
        //state_buf[i] = tid + i + 100;

        initstate_r(tid + 1, state_buf, PRNG_STATE_SIZE, &rng_state);
        
#pragma omp for
        for (int i = 0; i < NBOOTS; i++) {
            for (int j = 0; j < NTRACES; j++)
                //rnd[i][j] = rand();
                random_r(&rng_state, (int32_t *) &rnd[i][j]);
        }
    }
}

void compare(int rnd1[NBOOTS][NTRACES], int rnd2[NBOOTS][NTRACES]) {
    for (int i = 0; i < NBOOTS; i++)
        for (int j = 0; j < NTRACES; j++)
            if (rnd1[i][j] != rnd2[i][j]) {
                printf("DIFFERENT!\n");
                return;
            }
    printf("Identical\n");
}

int main() {
    init(first_run, -1);
    init(second_run, -1);

    compare(first_run, second_run);

    return 0;
}
