/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/mika/Projects/projects_workspace/VHDL_processor/VHDL_computer/data_ram.vhd";
extern char *IEEE_P_3620187407;

int ieee_p_3620187407_sub_5109402382352621412_3965413181(char *, char *, char *);


static void work_a_4172741549_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;

LAB0:    xsi_set_current_line(61, ng0);

LAB3:    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    t1 = (t0 + 7800U);
    t3 = ieee_p_3620187407_sub_5109402382352621412_3965413181(IEEE_P_3620187407, t2, t1);
    t4 = (t0 + 4592);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((int *)t8) = t3;
    xsi_driver_first_trans_fast(t4);

LAB2:    t9 = (t0 + 4480);
    *((int *)t9) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_4172741549_3212880686_p_1(char *t0)
{
    unsigned char t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    int t12;
    int t13;
    char *t14;
    char *t15;
    char *t16;
    int t17;
    int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;

LAB0:    xsi_set_current_line(64, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 4496);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(65, ng0);
    t4 = (t0 + 1192U);
    t8 = *((char **)t4);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)2);
    if (t10 != 0)
        goto LAB8;

LAB10:    t2 = (t0 + 1672U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = (t1 == (unsigned char)3);
    if (t3 != 0)
        goto LAB16;

LAB17:
LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)2);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(66, ng0);
    t4 = (t0 + 8456);
    *((int *)t4) = 31;
    t11 = (t0 + 8460);
    *((int *)t11) = 0;
    t12 = 31;
    t13 = 0;

LAB11:    if (t12 >= t13)
        goto LAB12;

LAB14:    goto LAB9;

LAB12:    xsi_set_current_line(67, ng0);
    t14 = xsi_get_transient_memory(16U);
    memset(t14, 0, 16U);
    t15 = t14;
    memset(t15, (unsigned char)2, 16U);
    t16 = (t0 + 8456);
    t17 = *((int *)t16);
    t18 = (t17 - 31);
    t19 = (t18 * -1);
    t20 = (16U * t19);
    t21 = (0U + t20);
    t22 = (t0 + 4656);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    memcpy(t26, t14, 16U);
    xsi_driver_first_trans_delta(t22, t21, 16U, 0LL);

LAB13:    t2 = (t0 + 8456);
    t12 = *((int *)t2);
    t4 = (t0 + 8460);
    t13 = *((int *)t4);
    if (t12 == t13)
        goto LAB14;

LAB15:    t17 = (t12 + -1);
    t12 = t17;
    t5 = (t0 + 8456);
    *((int *)t5) = t12;
    goto LAB11;

LAB16:    xsi_set_current_line(70, ng0);
    t2 = (t0 + 1512U);
    t5 = *((char **)t2);
    t2 = (t0 + 2152U);
    t8 = *((char **)t2);
    t12 = *((int *)t8);
    t13 = (t12 - 31);
    t19 = (t13 * -1);
    t20 = (16U * t19);
    t21 = (0U + t20);
    t2 = (t0 + 4656);
    t11 = (t2 + 56U);
    t14 = *((char **)t11);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t5, 16U);
    xsi_driver_first_trans_delta(t2, t21, 16U, 0LL);
    goto LAB9;

}

static void work_a_4172741549_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;

LAB0:    xsi_set_current_line(75, ng0);

LAB3:    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t1 = (t0 + 2152U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 31);
    t6 = (t5 * -1);
    xsi_vhdl_check_range_of_index(31, 0, -1, t4);
    t7 = (16U * t6);
    t8 = (0 + t7);
    t1 = (t2 + t8);
    t9 = (t0 + 4720);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t1, 16U);
    xsi_driver_first_trans_fast_port(t9);

LAB2:    t14 = (t0 + 4512);
    *((int *)t14) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_4172741549_3212880686_init()
{
	static char *pe[] = {(void *)work_a_4172741549_3212880686_p_0,(void *)work_a_4172741549_3212880686_p_1,(void *)work_a_4172741549_3212880686_p_2};
	xsi_register_didat("work_a_4172741549_3212880686", "isim/data_ram_tb_isim_beh.exe.sim/work/a_4172741549_3212880686.didat");
	xsi_register_executes(pe);
}
