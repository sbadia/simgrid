#include <stdio.h>
#include <mpi.h>


int main (int argc, char **argv) {
	  int size, rank;
	  int root=0;
	  int value;
	  double start_timer;

	  MPI_Init(&argc, &argv);
	  MPI_Comm_size(MPI_COMM_WORLD, &size);
	  MPI_Comm_rank(MPI_COMM_WORLD, &rank);

  start_timer = MPI_Wtime();

  MPI_Barrier( MPI_COMM_WORLD );

  MPI_Barrier( MPI_COMM_WORLD );
  if (0 == rank) {
          printf("... Barrier ....\n");
          printf("Elapsed=%lf s\n", MPI_Wtime() - start_timer);
  }

  MPI_Finalize();
  return 0;
}
