------------------------------------------------------------------------------
--                                                                          --
--                     Copyright (C) 2015-2017, AdaCore                     --
--                                                                          --
--  Redistribution and use in source and binary forms, with or without      --
--  modification, are permitted provided that the following conditions are  --
--  met:                                                                    --
--     1. Redistributions of source code must retain the above copyright    --
--        notice, this list of conditions and the following disclaimer.     --
--     2. Redistributions in binary form must reproduce the above copyright --
--        notice, this list of conditions and the following disclaimer in   --
--        the documentation and/or other materials provided with the        --
--        distribution.                                                     --
--     3. Neither the name of STMicroelectronics nor the names of its       --
--        contributors may be used to endorse or promote products derived   --
--        from this software without specific prior written permission.     --
--                                                                          --
--   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS    --
--   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT      --
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR  --
--   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT   --
--   HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, --
--   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT       --
--   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,  --
--   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY  --
--   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT    --
--   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE  --
--   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.   --
--                                                                          --
--                                                                          --
--  This file is based on:                                                  --
--                                                                          --
--   @file    stm32f40[5|7]xx.h                                             --
--   @author  MCD Application Team                                          --
--   @version V1.1.0                                                        --
--   @date    19-June-2014                                                  --
--   @brief   CMSIS STM32F407xx Device Peripheral Access Layer Header File. --
--                                                                          --
--   COPYRIGHT(c) 2014 STMicroelectronics                                   --
------------------------------------------------------------------------------

--  This file provides declarations for devices on the STM32F40xxx MCUs
--  manufactured by ST Microelectronics.  For example, an STM32F405.

with STM32_SVD;            use STM32_SVD;

with STM32.DMA;            use STM32.DMA;
with STM32.DMA.Interrupts; use STM32.DMA.Interrupts;
with STM32.GPIO;           use STM32.GPIO;
with STM32.ADC;            use STM32.ADC;
with STM32.USARTs;         use STM32.USARTs;
with STM32.SPI;            use STM32.SPI;
with STM32.SPI.DMA;        use STM32.SPI.DMA;
with STM32.I2S;            use STM32.I2S;
with STM32.Timers;         use STM32.Timers;
with STM32.I2C;            use STM32.I2C;
with STM32.I2C.DMA;        use STM32.I2C.DMA;
with STM32.RTC;            use STM32.RTC;

with Ada.Interrupts.Names;

package STM32.Device is
   pragma Elaborate_Body;

   Unknown_Device : exception;
   --  Raised by the routines below for a device passed as an actual parameter
   --  when that device is not present on the given hardware instance.

   procedure Enable_Clock (This : aliased in out GPIO_Port);
   procedure Enable_Clock (Point : GPIO_Point);
   procedure Enable_Clock (Points : GPIO_Points);

   procedure Reset (This : aliased in out GPIO_Port)
     with Inline;
   procedure Reset (Point : GPIO_Point)
     with Inline;
   procedure Reset (Points : GPIO_Points)
     with Inline;

   function GPIO_Port_Representation (Port : GPIO_Port) return UInt4
     with Inline;

   GPIO_A : aliased GPIO_Port with Import, Volatile, Address => GPIOA_Base;
   GPIO_B : aliased GPIO_Port with Import, Volatile, Address => GPIOB_Base;
   GPIO_C : aliased GPIO_Port with Import, Volatile, Address => GPIOC_Base;
   GPIO_D : aliased GPIO_Port with Import, Volatile, Address => GPIOD_Base;
   GPIO_H : aliased GPIO_Port with Import, Volatile, Address => GPIOH_Base;


   PA0  : aliased GPIO_Point := (GPIO_A'Access, Pin_0);
   PA1  : aliased GPIO_Point := (GPIO_A'Access, Pin_1);
   PA2  : aliased GPIO_Point := (GPIO_A'Access, Pin_2);
   PA3  : aliased GPIO_Point := (GPIO_A'Access, Pin_3);
   PA4  : aliased GPIO_Point := (GPIO_A'Access, Pin_4);
   PA5  : aliased GPIO_Point := (GPIO_A'Access, Pin_5);
   PA6  : aliased GPIO_Point := (GPIO_A'Access, Pin_6);
   PA7  : aliased GPIO_Point := (GPIO_A'Access, Pin_7);
   PA8  : aliased GPIO_Point := (GPIO_A'Access, Pin_8);
   PA9  : aliased GPIO_Point := (GPIO_A'Access, Pin_9);
   PA10 : aliased GPIO_Point := (GPIO_A'Access, Pin_10);
   PA11 : aliased GPIO_Point := (GPIO_A'Access, Pin_11);
   PA12 : aliased GPIO_Point := (GPIO_A'Access, Pin_12);
   PA13 : aliased GPIO_Point := (GPIO_A'Access, Pin_13);
   PA14 : aliased GPIO_Point := (GPIO_A'Access, Pin_14);
   PA15 : aliased GPIO_Point := (GPIO_A'Access, Pin_15);
   PB0  : aliased GPIO_Point := (GPIO_B'Access, Pin_0);
   PB1  : aliased GPIO_Point := (GPIO_B'Access, Pin_1);
   PB2  : aliased GPIO_Point := (GPIO_B'Access, Pin_2);
   PB3  : aliased GPIO_Point := (GPIO_B'Access, Pin_3);
   PB4  : aliased GPIO_Point := (GPIO_B'Access, Pin_4);
   PB5  : aliased GPIO_Point := (GPIO_B'Access, Pin_5);
   PB6  : aliased GPIO_Point := (GPIO_B'Access, Pin_6);
   PB7  : aliased GPIO_Point := (GPIO_B'Access, Pin_7);
   PB8  : aliased GPIO_Point := (GPIO_B'Access, Pin_8);
   PB9  : aliased GPIO_Point := (GPIO_B'Access, Pin_9);
   PB10 : aliased GPIO_Point := (GPIO_B'Access, Pin_10);
   PB11 : aliased GPIO_Point := (GPIO_B'Access, Pin_11);
   PB12 : aliased GPIO_Point := (GPIO_B'Access, Pin_12);
   PB13 : aliased GPIO_Point := (GPIO_B'Access, Pin_13);
   PB14 : aliased GPIO_Point := (GPIO_B'Access, Pin_14);
   PB15 : aliased GPIO_Point := (GPIO_B'Access, Pin_15);
   PC0  : aliased GPIO_Point := (GPIO_C'Access, Pin_0);
   PC1  : aliased GPIO_Point := (GPIO_C'Access, Pin_1);
   PC2  : aliased GPIO_Point := (GPIO_C'Access, Pin_2);
   PC3  : aliased GPIO_Point := (GPIO_C'Access, Pin_3);
   PC4  : aliased GPIO_Point := (GPIO_C'Access, Pin_4);
   PC5  : aliased GPIO_Point := (GPIO_C'Access, Pin_5);
   PC6  : aliased GPIO_Point := (GPIO_C'Access, Pin_6);
   PC7  : aliased GPIO_Point := (GPIO_C'Access, Pin_7);
   PC8  : aliased GPIO_Point := (GPIO_C'Access, Pin_8);
   PC9  : aliased GPIO_Point := (GPIO_C'Access, Pin_9);
   PC10 : aliased GPIO_Point := (GPIO_C'Access, Pin_10);
   PC11 : aliased GPIO_Point := (GPIO_C'Access, Pin_11);
   PC12 : aliased GPIO_Point := (GPIO_C'Access, Pin_12);
   PC13 : aliased GPIO_Point := (GPIO_C'Access, Pin_13);
   PC14 : aliased GPIO_Point := (GPIO_C'Access, Pin_14);
   PC15 : aliased GPIO_Point := (GPIO_C'Access, Pin_15);
   PD0  : aliased GPIO_Point := (GPIO_D'Access, Pin_0);
   PD1  : aliased GPIO_Point := (GPIO_D'Access, Pin_1);
   PD2  : aliased GPIO_Point := (GPIO_D'Access, Pin_2);
   PD3  : aliased GPIO_Point := (GPIO_D'Access, Pin_3);
   PD4  : aliased GPIO_Point := (GPIO_D'Access, Pin_4);
   PD5  : aliased GPIO_Point := (GPIO_D'Access, Pin_5);
   PD6  : aliased GPIO_Point := (GPIO_D'Access, Pin_6);
   PD7  : aliased GPIO_Point := (GPIO_D'Access, Pin_7);
   PD8  : aliased GPIO_Point := (GPIO_D'Access, Pin_8);
   PD9  : aliased GPIO_Point := (GPIO_D'Access, Pin_9);
   PD10 : aliased GPIO_Point := (GPIO_D'Access, Pin_10);
   PD11 : aliased GPIO_Point := (GPIO_D'Access, Pin_11);
   PD12 : aliased GPIO_Point := (GPIO_D'Access, Pin_12);
   PD13 : aliased GPIO_Point := (GPIO_D'Access, Pin_13);
   PD14 : aliased GPIO_Point := (GPIO_D'Access, Pin_14);
   PD15 : aliased GPIO_Point := (GPIO_D'Access, Pin_15);
   PH0  : aliased GPIO_Point := (GPIO_H'Access, Pin_0);
   PH1  : aliased GPIO_Point := (GPIO_H'Access, Pin_1);

   GPIO_AF_RTC_50Hz_0  : constant GPIO_Alternate_Function;
   GPIO_AF_MCO_0       : constant GPIO_Alternate_Function;
   GPIO_AF_TAMPER_0    : constant GPIO_Alternate_Function;
   GPIO_AF_SWJ_0       : constant GPIO_Alternate_Function;
   GPIO_AF_TRACE_0     : constant GPIO_Alternate_Function;
   GPIO_AF_TIM1_1      : constant GPIO_Alternate_Function;
   GPIO_AF_TIM2_1      : constant GPIO_Alternate_Function;
   GPIO_AF_TIM3_2      : constant GPIO_Alternate_Function;
   GPIO_AF_TIM4_2      : constant GPIO_Alternate_Function;
   GPIO_AF_TIM5_2      : constant GPIO_Alternate_Function;
   GPIO_AF_TIM8_3      : constant GPIO_Alternate_Function;
   GPIO_AF_TIM9_3      : constant GPIO_Alternate_Function;
   GPIO_AF_TIM10_3     : constant GPIO_Alternate_Function;
   GPIO_AF_TIM11_3     : constant GPIO_Alternate_Function;
   GPIO_AF_I2C1_4      : constant GPIO_Alternate_Function;
   GPIO_AF_I2C2_4      : constant GPIO_Alternate_Function;
   GPIO_AF_I2C3_4      : constant GPIO_Alternate_Function;
   GPIO_AF_SPI1_5      : constant GPIO_Alternate_Function;
   GPIO_AF_SPI2_5      : constant GPIO_Alternate_Function;
   GPIO_AF_I2S2_5      : constant GPIO_Alternate_Function;
   GPIO_AF_I2S2ext_5   : constant GPIO_Alternate_Function;
   GPIO_AF_SPI3_6      : constant GPIO_Alternate_Function;
   GPIO_AF_I2S3_6      : constant GPIO_Alternate_Function;
   GPIO_AF_I2Sext_6    : constant GPIO_Alternate_Function;
   GPIO_AF_I2S3ext_7   : constant GPIO_Alternate_Function;
   GPIO_AF_USART1_7    : constant GPIO_Alternate_Function;
   GPIO_AF_USART2_7    : constant GPIO_Alternate_Function;
   GPIO_AF_USART3_7    : constant GPIO_Alternate_Function;
   GPIO_AF_UART4_8     : constant GPIO_Alternate_Function;
   GPIO_AF_UART5_8     : constant GPIO_Alternate_Function;
   GPIO_AF_USART6_8    : constant GPIO_Alternate_Function;
   GPIO_AF_CAN1_9      : constant GPIO_Alternate_Function;
   GPIO_AF_CAN2_9      : constant GPIO_Alternate_Function;
   GPIO_AF_TIM12_9     : constant GPIO_Alternate_Function;
   GPIO_AF_TIM13_9     : constant GPIO_Alternate_Function;
   GPIO_AF_TIM14_9     : constant GPIO_Alternate_Function;
   GPIO_AF_OTG_FS_10   : constant GPIO_Alternate_Function;
   GPIO_AF_OTG_HS_10   : constant GPIO_Alternate_Function;
   GPIO_AF_ETH_11      : constant GPIO_Alternate_Function;
   GPIO_AF_FMC_12      : constant GPIO_Alternate_Function;
   GPIO_AF_OTG_FS_12   : constant GPIO_Alternate_Function;
   GPIO_AF_SDIO_12     : constant GPIO_Alternate_Function;
   GPIO_AF_DCMI_13     : constant GPIO_Alternate_Function;
   GPIO_AF_EVENTOUT_15 : constant GPIO_Alternate_Function;

   ADC_1 : aliased Analog_To_Digital_Converter with Volatile, Import, Address => ADC1_Base;

   VBat : constant ADC_Point := (ADC_1'Access, Channel => VBat_Channel);

   Temperature_Channel : constant TemperatureSensor_Channel := 16;
   Temperature_Sensor  : constant ADC_Point :=
     (ADC_1'Access, Channel => Temperature_Channel);
   --  see RM pg 410, section 13.10, also pg 389

   VBat_Bridge_Divisor : constant := 2;
   --  The VBAT pin is internally connected to a bridge divider. The actual
   --  voltage is the raw conversion value * the divisor. See section 13.11,
   --  pg 412 of the RM.

   procedure Enable_Clock (This : aliased in out Analog_To_Digital_Converter);

   procedure Reset_All_ADC_Units;

   Internal_USART_1 : aliased Internal_USART with Import, Volatile, Address => USART1_Base;
   Internal_USART_2 : aliased Internal_USART with Import, Volatile, Address => USART2_Base;
   Internal_USART_6 : aliased Internal_USART with Import, Volatile, Address => USART6_Base;

   USART_1 : aliased USART (Internal_USART_1'Access);
   USART_2 : aliased USART (Internal_USART_2'Access);
   USART_6 : aliased USART (Internal_USART_6'Access);

   procedure Enable_Clock (This : aliased in out USART);

   procedure Reset (This : aliased in out USART);

   DMA_1 : aliased DMA_Controller with Import, Volatile, Address => DMA1_Base;
   DMA_2 : aliased DMA_Controller with Import, Volatile, Address => DMA2_Base;

   procedure Enable_Clock (This : aliased in out DMA_Controller);
   procedure Reset (This : aliased in out DMA_Controller);

   DMA1_Stream0 : aliased DMA_Interrupt_Controller
     (DMA_1'Access, Stream_0, Ada.Interrupts.Names.DMA1_Stream0_Interrupt);
   DMA1_Stream1 : aliased DMA_Interrupt_Controller
     (DMA_1'Access, Stream_1, Ada.Interrupts.Names.DMA1_Stream1_Interrupt);
   DMA1_Stream2 : aliased DMA_Interrupt_Controller
     (DMA_1'Access, Stream_2, Ada.Interrupts.Names.DMA1_Stream2_Interrupt);
   DMA1_Stream3 : aliased DMA_Interrupt_Controller
     (DMA_1'Access, Stream_3, Ada.Interrupts.Names.DMA1_Stream3_Interrupt);
   DMA1_Stream4 : aliased DMA_Interrupt_Controller
     (DMA_1'Access, Stream_4, Ada.Interrupts.Names.DMA1_Stream4_Interrupt);
   DMA1_Stream5 : aliased DMA_Interrupt_Controller
     (DMA_1'Access, Stream_5, Ada.Interrupts.Names.DMA1_Stream5_Interrupt);
   DMA1_Stream6 : aliased DMA_Interrupt_Controller
     (DMA_1'Access, Stream_6, Ada.Interrupts.Names.DMA1_Stream6_Interrupt);
   DMA1_Stream7 : aliased DMA_Interrupt_Controller
     (DMA_1'Access, Stream_7, Ada.Interrupts.Names.DMA1_Stream7_Interrupt);

   DMA2_Stream0 : aliased DMA_Interrupt_Controller
     (DMA_2'Access, Stream_0, Ada.Interrupts.Names.DMA2_Stream0_Interrupt);
   DMA2_Stream1 : aliased DMA_Interrupt_Controller
     (DMA_2'Access, Stream_1, Ada.Interrupts.Names.DMA2_Stream1_Interrupt);
   DMA2_Stream2 : aliased DMA_Interrupt_Controller
     (DMA_2'Access, Stream_2, Ada.Interrupts.Names.DMA2_Stream2_Interrupt);
   DMA2_Stream3 : aliased DMA_Interrupt_Controller
     (DMA_2'Access, Stream_3, Ada.Interrupts.Names.DMA2_Stream3_Interrupt);
   DMA2_Stream4 : aliased DMA_Interrupt_Controller
     (DMA_2'Access, Stream_4, Ada.Interrupts.Names.DMA2_Stream4_Interrupt);
   DMA2_Stream5 : aliased DMA_Interrupt_Controller
     (DMA_2'Access, Stream_5, Ada.Interrupts.Names.DMA2_Stream5_Interrupt);
   DMA2_Stream6 : aliased DMA_Interrupt_Controller
     (DMA_2'Access, Stream_6, Ada.Interrupts.Names.DMA2_Stream6_Interrupt);
   DMA2_Stream7 : aliased DMA_Interrupt_Controller
     (DMA_2'Access, Stream_7, Ada.Interrupts.Names.DMA2_Stream7_Interrupt);

   Internal_I2C_Port_1 : aliased Internal_I2C_Port with Import, Volatile, Address => I2C1_Base;
   Internal_I2C_Port_2 : aliased Internal_I2C_Port with Import, Volatile, Address => I2C2_Base;
   Internal_I2C_Port_3 : aliased Internal_I2C_Port with Import, Volatile, Address => I2C3_Base;

   type I2C_Port_Id is (I2C_Id_1, I2C_Id_2, I2C_Id_3);

   I2C_1 : aliased I2C_Port (Internal_I2C_Port_1'Access);
   I2C_2 : aliased I2C_Port (Internal_I2C_Port_2'Access);
   I2C_3 : aliased I2C_Port (Internal_I2C_Port_3'Access);

   I2C_1_DMA : aliased I2C_Port_DMA (Internal_I2C_Port_1'Access);
   I2C_2_DMA : aliased I2C_Port_DMA (Internal_I2C_Port_2'Access);
   I2C_3_DMA : aliased I2C_Port_DMA (Internal_I2C_Port_3'Access);

   function As_Port_Id (Port : I2C_Port'Class) return I2C_Port_Id with Inline;

   procedure Enable_Clock (This : aliased I2C_Port'Class);
   procedure Enable_Clock (This : I2C_Port_Id);

   procedure Reset (This : I2C_Port'Class);
   procedure Reset (This : I2C_Port_Id);

   Internal_SPI_1 : aliased Internal_SPI_Port with Import, Volatile, Address => SPI1_Base;
   Internal_SPI_2 : aliased Internal_SPI_Port with Import, Volatile, Address => SPI2_Base;
   Internal_SPI_3 : aliased Internal_SPI_Port with Import, Volatile, Address => SPI3_Base;

   SPI_1 : aliased SPI_Port (Internal_SPI_1'Access);
   SPI_2 : aliased SPI_Port (Internal_SPI_2'Access);
   SPI_3 : aliased SPI_Port (Internal_SPI_3'Access);

   SPI_1_DMA : aliased SPI_Port_DMA (Internal_SPI_1'Access);
   SPI_2_DMA : aliased SPI_Port_DMA (Internal_SPI_2'Access);
   SPI_3_DMA : aliased SPI_Port_DMA (Internal_SPI_3'Access);

   procedure Enable_Clock (This : SPI_Port'Class);
   procedure Reset (This : in out SPI_Port'Class);

   Internal_I2S_1     : aliased Internal_I2S_Port with Import, Volatile, Address => SPI1_Base;
   Internal_I2S_2     : aliased Internal_I2S_Port with Import, Volatile, Address => SPI2_Base;
   Internal_I2S_3     : aliased Internal_I2S_Port with Import, Volatile, Address => SPI3_Base;
   Internal_I2S_2_Ext : aliased Internal_I2S_Port with Import, Volatile, Address => I2S2ext_Base;
   Internal_I2S_3_Ext : aliased Internal_I2S_Port with Import, Volatile, Address => I2S3ext_Base;

   I2S_1 : aliased I2S_Port (Internal_I2S_1'Access, Extended => False);
   I2S_2 : aliased I2S_Port (Internal_I2S_2'Access, Extended => False);
   I2S_3 : aliased I2S_Port (Internal_I2S_3'Access, Extended => False);

   I2S_2_Ext : aliased I2S_Port (Internal_I2S_2_Ext'Access, Extended => True);
   I2S_3_Ext : aliased I2S_Port (Internal_I2S_3_Ext'Access, Extended => True);

   procedure Enable_Clock (This : I2S_Port);
   procedure Reset (This : in out I2S_Port);

   Timer_1  : aliased Timer with Import, Volatile, Address => TIM1_Base;
   Timer_2  : aliased Timer with Import, Volatile, Address => TIM2_Base;
   Timer_3  : aliased Timer with Import, Volatile, Address => TIM3_Base;
   Timer_4  : aliased Timer with Import, Volatile, Address => TIM4_Base;
   Timer_8  : aliased Timer with Import, Volatile, Address => TIM8_Base;
   Timer_9  : aliased Timer with Import, Volatile, Address => TIM9_Base;
   Timer_10 : aliased Timer with Import, Volatile, Address => TIM10_Base;
   Timer_11 : aliased Timer with Import, Volatile, Address => TIM11_Base;

   procedure Enable_Clock (This : in out Timer);

   procedure Reset (This : in out Timer);

   -----------------------------
   -- Reset and Clock Control --
   -----------------------------

   type RCC_System_Clocks is record
      SYSCLK  : UInt32;
      HCLK    : UInt32;
      PCLK1   : UInt32;
      PCLK2   : UInt32;
      TIMCLK1 : UInt32;
      TIMCLK2 : UInt32;
      I2SCLK  : UInt32;
   end record;

   function System_Clock_Frequencies return RCC_System_Clocks;

   procedure Set_PLLI2S_Factors (Pll_N : UInt9;
                                 Pll_R : UInt3);

   function PLLI2S_Enabled return Boolean;

   procedure Enable_PLLI2S
     with Post => PLLI2S_Enabled;

   procedure Disable_PLLI2S
     with Post => not PLLI2S_Enabled;


   RTC : aliased RTC_Device;

private

   GPIO_AF_RTC_50Hz_0  : constant GPIO_Alternate_Function := 0;
   GPIO_AF_MCO_0       : constant GPIO_Alternate_Function := 0;
   GPIO_AF_TAMPER_0    : constant GPIO_Alternate_Function := 0;
   GPIO_AF_SWJ_0       : constant GPIO_Alternate_Function := 0;
   GPIO_AF_TRACE_0     : constant GPIO_Alternate_Function := 0;
   GPIO_AF_TIM1_1      : constant GPIO_Alternate_Function := 1;
   GPIO_AF_TIM2_1      : constant GPIO_Alternate_Function := 1;
   GPIO_AF_TIM3_2      : constant GPIO_Alternate_Function := 2;
   GPIO_AF_TIM4_2      : constant GPIO_Alternate_Function := 2;
   GPIO_AF_TIM5_2      : constant GPIO_Alternate_Function := 2;
   GPIO_AF_TIM8_3      : constant GPIO_Alternate_Function := 3;
   GPIO_AF_TIM9_3      : constant GPIO_Alternate_Function := 3;
   GPIO_AF_TIM10_3     : constant GPIO_Alternate_Function := 3;
   GPIO_AF_TIM11_3     : constant GPIO_Alternate_Function := 3;
   GPIO_AF_I2C1_4      : constant GPIO_Alternate_Function := 4;
   GPIO_AF_I2C2_4      : constant GPIO_Alternate_Function := 4;
   GPIO_AF_I2C3_4      : constant GPIO_Alternate_Function := 4;
   GPIO_AF_SPI1_5      : constant GPIO_Alternate_Function := 5;
   GPIO_AF_SPI2_5      : constant GPIO_Alternate_Function := 5;
   GPIO_AF_I2S2_5      : constant GPIO_Alternate_Function := 5;
   GPIO_AF_I2S2ext_5   : constant GPIO_Alternate_Function := 5;
   GPIO_AF_SPI3_6      : constant GPIO_Alternate_Function := 6;
   GPIO_AF_I2S3_6      : constant GPIO_Alternate_Function := 6;
   GPIO_AF_I2Sext_6    : constant GPIO_Alternate_Function := 6;
   GPIO_AF_I2S3ext_7   : constant GPIO_Alternate_Function := 7;
   GPIO_AF_USART1_7    : constant GPIO_Alternate_Function := 7;
   GPIO_AF_USART2_7    : constant GPIO_Alternate_Function := 7;
   GPIO_AF_USART3_7    : constant GPIO_Alternate_Function := 7;
   GPIO_AF_UART4_8     : constant GPIO_Alternate_Function := 8;
   GPIO_AF_UART5_8     : constant GPIO_Alternate_Function := 8;
   GPIO_AF_USART6_8    : constant GPIO_Alternate_Function := 8;
   GPIO_AF_CAN1_9      : constant GPIO_Alternate_Function := 9;
   GPIO_AF_CAN2_9      : constant GPIO_Alternate_Function := 9;
   GPIO_AF_TIM12_9     : constant GPIO_Alternate_Function := 9;
   GPIO_AF_TIM13_9     : constant GPIO_Alternate_Function := 9;
   GPIO_AF_TIM14_9     : constant GPIO_Alternate_Function := 9;
   GPIO_AF_OTG_FS_10   : constant GPIO_Alternate_Function := 10;
   GPIO_AF_OTG_HS_10   : constant GPIO_Alternate_Function := 10;
   GPIO_AF_ETH_11      : constant GPIO_Alternate_Function := 11;
   GPIO_AF_FMC_12      : constant GPIO_Alternate_Function := 12;
   GPIO_AF_OTG_FS_12   : constant GPIO_Alternate_Function := 12;
   GPIO_AF_SDIO_12     : constant GPIO_Alternate_Function := 12;
   GPIO_AF_DCMI_13     : constant GPIO_Alternate_Function := 13;
   GPIO_AF_EVENTOUT_15 : constant GPIO_Alternate_Function := 15;

end STM32.Device;
