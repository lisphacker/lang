#include <mpi.h>
#include <stdio.h>

int main(int argc, char **argv) {
    int required = MPI_THREAD_MULTIPLE, available = -1;
    int rank = -1;
    
    if (MPI_Init_thread(&argc, &argv, required, &available) != MPI_SUCCESS) {
        perror("Failed to initialize MPI");
        return -1;
    }

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    if (rank == 0) {
        printf("available = %d\n\n", available);
        
        printf("MPI_THREAD_SINGLE = %d\n", MPI_THREAD_SINGLE);
        printf("MPI_THREAD_FUNNELED = %d\n", MPI_THREAD_FUNNELED);
        printf("MPI_THREAD_SERIALIZED = %d\n", MPI_THREAD_SERIALIZED);
        printf("MPI_THREAD_MULTIPLE = %d\n", MPI_THREAD_MULTIPLE);
    }

    MPI_Finalize();
    return 0;
}
