
/* 	$Id$	 */

/* Copyright (c) 2004 Arnaud Legrand. All rights reserved.                  */

/* This program is free software; you can redistribute it and/or modify it
 * under the terms of the license (GNU LGPL) which comes with this package. */

#ifndef _SURF_CPU_TI_PRIVATE_H
#define _SURF_CPU_TI_PRIVATE_H

/* TIMESERIES */
typedef struct surf_cpu_ti_timeSeries {
  long nb_points;               /*< Number of points in the series */
  double spacing;               /*< Spacing between two points */
  double *values;               /*< Array of size nb_points */
  tmgr_trace_t power_trace;     /*< Copy of power trace structure */
  int *trace_index;             /*< Array of index. Each element is the index of first point in interval [spacing*i, spacing*(i+1)[ . Negative value indicates that there are no points in this spacing interval */
  double *trace_value;          /*< Array with the date when the event trace_index[i] happens. */
} s_surf_cpu_ti_timeSeries_t, *surf_cpu_ti_timeSeries_t;

/* TRACE */
typedef struct surf_cpu_ti_tgmr {
  enum trace_type {
    TRACE_FIXED,                /*< Trace fixed, no availability file */
    TRACE_DYNAMIC               /*< Dynamic, availability file disponible */
  } type;

  double value;                 /*< Percentage of cpu power disponible. Value fixed between 0 and 1 */

  /* Dynamic */
  double last_time;             /*< Integral interval last point (discret time) */
  double actual_last_time;      /*< Actual size of integral interval */
  double total;                 /*< Integral total between 0 and last_pointn */

  surf_cpu_ti_timeSeries_t *levels;     /*< Availability information */
  int nb_levels;                /*< Number of levels */
} s_surf_cpu_ti_tgmr_t, *surf_cpu_ti_tgmr_t;


/* CPU with trace integration feature */
typedef struct cpu_ti {
  s_surf_resource_t generic_resource;   /*< Structure with generic data. Needed at begin to interate with SURF */
  double power_peak;            /*< CPU power peak */
  double power_scale;           /*< Percentage of CPU disponible */
  surf_cpu_ti_tgmr_t avail_trace;       /*< Structure with data needed to integrate trace file */
  e_surf_resource_state_t state_current;        /*< CPU current state (ON or OFF) */
  tmgr_trace_event_t state_event;       /*< trace file with states events (ON or OFF) */
  tmgr_trace_event_t power_event;       /*< trace file with availabitly events */
  xbt_swag_t action_set;        /*< set with all actions running on cpu */
  s_xbt_swag_hookup_t modified_cpu_hookup;      /*< hookup to swag that indicacates whether share resources must be recalculated or not */
  double sum_priority;          /*< the sum of actions' priority that are running on cpu */
  double last_update;           /*< last update of actions' remaining amount done */
} s_cpu_ti_t, *cpu_ti_t;

typedef struct surf_action_ti {
  s_surf_action_t generic_action;
  s_xbt_swag_hookup_t cpu_list_hookup;
  void *cpu;
  int suspended;
  int index_heap;
} s_surf_action_cpu_ti_t, *surf_action_cpu_ti_t;

/* Time-step for resource performance traces */
#define TRACE_TIMESTEP 10.00
/* Number of levels for resource performance traces */
#define TRACE_NB_LEVELS 4
/* Epsilon */
#define EPSILON 0.000000001
/* Usefull define to get the cpu where action is running on */
#define ACTION_GET_CPU(action) ((cpu_ti_t)((surf_action_cpu_ti_t)action)->cpu)


#endif /* _SURF_CPU_TI_PRIVATE_H */