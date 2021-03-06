/* Copyright (c) 2007, 2008, 2009, 2010. The SimGrid Team.
 * All rights reserved.                                                     */

/* This program is free software; you can redistribute it and/or modify it
 * under the terms of the license (GNU LGPL) which comes with this package. */

#ifndef _SIMIX_HOST_PRIVATE_H
#define _SIMIX_HOST_PRIVATE_H

#include "simix/datatypes.h"
#include "smurf_private.h"

/** @brief Host datatype */
typedef struct s_smx_host {
  char *name;              /**< @brief host name if any */
  void *host;                   /* SURF modeling */
  xbt_swag_t process_list;
  void *data;              /**< @brief user data */
} s_smx_host_t;

smx_host_t SIMIX_host_create(const char *name, void *workstation, void *data);
void SIMIX_host_destroy(void *host);
void SIMIX_host_set_data(smx_host_t host, void *data);
void* SIMIX_host_get_data(smx_host_t host);
xbt_dict_t SIMIX_host_get_properties(smx_host_t host);
double SIMIX_host_get_speed(smx_host_t host);
double SIMIX_host_get_available_speed(smx_host_t host);
int SIMIX_host_get_state(smx_host_t host);
smx_action_t SIMIX_host_execute(const char *name,
    smx_host_t host, double computation_amount, double priority);
smx_action_t SIMIX_host_parallel_execute(const char *name,
    int host_nb, smx_host_t *host_list,
    double *computation_amount, double *communication_amount,
    double amount, double rate);
void SIMIX_host_execution_destroy(smx_action_t action);
void SIMIX_host_execution_cancel(smx_action_t action);
double SIMIX_host_execution_get_remains(smx_action_t action);
e_smx_state_t SIMIX_host_execution_get_state(smx_action_t action);
void SIMIX_host_execution_set_priority(smx_action_t action, double priority);
void SIMIX_pre_host_execution_wait(smx_req_t req);

void SIMIX_host_execution_suspend(smx_action_t action);
void SIMIX_host_execution_resume(smx_action_t action);

void SIMIX_post_host_execute(smx_action_t action);

#ifdef HAVE_TRACING
void SIMIX_set_category(smx_action_t action, const char *category);
#endif

#endif

