# Profile and compare add() function

## Decimal.add()

```
mix profile.fprof -e ApaExample.profile --callers --details
Warmup...
Reading trace data...

End of trace!
Processing data...
Creating output...
Done!

                                                                   CNT    ACC (ms)    OWN (ms)     
Total                                                               27       0.047       0.047     

:undefined                                                           0       0.047       0.005     
  :fprof.apply_start_stop/4                                          0       0.047       0.005  <--
    anonymous fn/0 in :elixir_compiler_1.__FILE__/1                  1       0.041       0.001     
    :fprof."-apply_start_stop/4-after$^1/0-0-"/3                     1       0.001       0.001     

:fprof.apply_start_stop/4                                            1       0.041       0.001     
  anonymous fn/0 in :elixir_compiler_1.__FILE__/1                    1       0.041       0.001  <--
    ApaExample.profile/0                                             1       0.040       0.001     

anonymous fn/0 in :elixir_compiler_1.__FILE__/1                      1       0.040       0.001     
  ApaExample.profile/0                                               1       0.040       0.001  <--
    Decimal.add/2                                                    1       0.039       0.005     

ApaExample.profile/0                                                 1       0.039       0.005     
  Decimal.add/2                                                      1       0.039       0.005  <--
    Decimal.context/1                                                1       0.031       0.001     
    :erlang.min/2                                                    1       0.001       0.001     
    Decimal.add_sign/3                                               1       0.001       0.001     
    Decimal.add_align/4                                              1       0.001       0.001     

Decimal.add/2                                                        1       0.031       0.001     
  Decimal.context/1                                                  1       0.031       0.001  <--
    Decimal.context/2                                                1       0.030       0.006     

Decimal.context/1                                                    1       0.030       0.006     
  Decimal.context/2                                                  1       0.030       0.006  <--
    Decimal.handle_error/4                                           1       0.016       0.005     
    Decimal.put_uniq/2                                               1       0.003       0.001     
    Decimal.precision/3                                              1       0.003       0.002     
    Decimal.Context.get/0                                            1       0.002       0.001     

Decimal.context/2                                                    1       0.016       0.005     
  Decimal.handle_error/4                                             1       0.016       0.005  <--
    Decimal.Context.set/1                                            1       0.005       0.002     
    Enum.find/2                                                      1       0.003       0.001     
    Enum.reduce/3                                                    1       0.002       0.001     
    List.wrap/1                                                      1       0.001       0.001     

Decimal.handle_error/4                                               1       0.005       0.002     
  Decimal.Context.set/1                                              1       0.005       0.002  <--
    Process.put/2                                                    1       0.003       0.002     

Decimal.put_uniq/2                                                   1       0.002       0.001     
Decimal.handle_error/4                                               1       0.002       0.001     
  Enum.reduce/3                                                      2       0.004       0.002  <--
    Enum."-reduce/3-lists^foldl/2-0-"/3                              2       0.002       0.002     

Decimal.Context.set/1                                                1       0.003       0.002     
  Process.put/2                                                      1       0.003       0.002  <--
    :erlang.put/2                                                    1       0.001       0.001     

Decimal.handle_error/4                                               1       0.003       0.001     
  Enum.find/2                                                        1       0.003       0.001  <--
    Enum.find/3                                                      1       0.002       0.001     

Decimal.context/2                                                    1       0.003       0.001     
  Decimal.put_uniq/2                                                 1       0.003       0.001  <--
    Enum.reduce/3                                                    1       0.002       0.001     

Decimal.context/2                                                    1       0.003       0.002     
  Decimal.precision/3                                                1       0.003       0.002  <--
    :erlang.integer_to_list/1                                        1       0.001       0.001     

Enum.find/2                                                          1       0.002       0.001     
  Enum.find/3                                                        1       0.002       0.001  <--
    Enum.find_list/3                                                 1       0.001       0.001     

Enum.reduce/3                                                        2       0.002       0.002     
  Enum."-reduce/3-lists^foldl/2-0-"/3                                2       0.002       0.002  <--

Decimal.context/2                                                    1       0.002       0.001     
  Decimal.Context.get/0                                              1       0.002       0.001  <--
    Process.get/2                                                    1       0.001       0.001     

:fprof.apply_start_stop/4                                            1       0.001       0.001     
  :fprof."-apply_start_stop/4-after$^1/0-0-"/3                       1       0.001       0.001  <--
    :suspend                                                         1       0.000       0.000     

Process.put/2                                                        1       0.001       0.001     
  :erlang.put/2                                                      1       0.001       0.001  <--

Decimal.add/2                                                        1       0.001       0.001     
  :erlang.min/2                                                      1       0.001       0.001  <--

Decimal.precision/3                                                  1       0.001       0.001     
  :erlang.integer_to_list/1                                          1       0.001       0.001  <--

Decimal.Context.get/0                                                1       0.001       0.001     
  Process.get/2                                                      1       0.001       0.001  <--

Decimal.handle_error/4                                               1       0.001       0.001     
  List.wrap/1                                                        1       0.001       0.001  <--

Enum.find/3                                                          1       0.001       0.001     
  Enum.find_list/3                                                   1       0.001       0.001  <--

Decimal.add/2                                                        1       0.001       0.001     
  Decimal.add_sign/3                                                 1       0.001       0.001  <--

Decimal.add/2                                                        1       0.001       0.001     
  Decimal.add_align/4                                                1       0.001       0.001  <--

  :undefined                                                         0       0.000       0.000  <--
    :fprof.apply_start_stop/4                                        0       0.047       0.005     

:fprof."-apply_start_stop/4-after$^1/0-0-"/3                         1       0.000       0.000     
  :suspend                                                           1       0.000       0.000  <--

----------------------------------------------------------------------------------------------------
<0.93.0>                                                            27                   0.047     


:undefined                                                           0       0.047       0.005     
  :fprof.apply_start_stop/4                                          0       0.047       0.005  <--
    anonymous fn/0 in :elixir_compiler_1.__FILE__/1                  1       0.041       0.001     
    :fprof."-apply_start_stop/4-after$^1/0-0-"/3                     1       0.001       0.001     

:fprof.apply_start_stop/4                                            1       0.041       0.001     
  anonymous fn/0 in :elixir_compiler_1.__FILE__/1                    1       0.041       0.001  <--
    ApaExample.profile/0                                             1       0.040       0.001     

anonymous fn/0 in :elixir_compiler_1.__FILE__/1                      1       0.040       0.001     
  ApaExample.profile/0                                               1       0.040       0.001  <--
    Decimal.add/2                                                    1       0.039       0.005     

ApaExample.profile/0                                                 1       0.039       0.005     
  Decimal.add/2                                                      1       0.039       0.005  <--
    Decimal.context/1                                                1       0.031       0.001     
    :erlang.min/2                                                    1       0.001       0.001     
    Decimal.add_sign/3                                               1       0.001       0.001     
    Decimal.add_align/4                                              1       0.001       0.001     

Decimal.add/2                                                        1       0.031       0.001     
  Decimal.context/1                                                  1       0.031       0.001  <--
    Decimal.context/2                                                1       0.030       0.006     

Decimal.context/1                                                    1       0.030       0.006     
  Decimal.context/2                                                  1       0.030       0.006  <--
    Decimal.handle_error/4                                           1       0.016       0.005     
    Decimal.put_uniq/2                                               1       0.003       0.001     
    Decimal.precision/3                                              1       0.003       0.002     
    Decimal.Context.get/0                                            1       0.002       0.001     

Decimal.context/2                                                    1       0.016       0.005     
  Decimal.handle_error/4                                             1       0.016       0.005  <--
    Decimal.Context.set/1                                            1       0.005       0.002     
    Enum.find/2                                                      1       0.003       0.001     
    Enum.reduce/3                                                    1       0.002       0.001     
    List.wrap/1                                                      1       0.001       0.001     

Decimal.handle_error/4                                               1       0.005       0.002     
  Decimal.Context.set/1                                              1       0.005       0.002  <--
    Process.put/2                                                    1       0.003       0.002     

Decimal.put_uniq/2                                                   1       0.002       0.001     
Decimal.handle_error/4                                               1       0.002       0.001     
  Enum.reduce/3                                                      2       0.004       0.002  <--
    Enum."-reduce/3-lists^foldl/2-0-"/3                              2       0.002       0.002     

Decimal.Context.set/1                                                1       0.003       0.002     
  Process.put/2                                                      1       0.003       0.002  <--
    :erlang.put/2                                                    1       0.001       0.001     

Decimal.handle_error/4                                               1       0.003       0.001     
  Enum.find/2                                                        1       0.003       0.001  <--
    Enum.find/3                                                      1       0.002       0.001     

Decimal.context/2                                                    1       0.003       0.001     
  Decimal.put_uniq/2                                                 1       0.003       0.001  <--
    Enum.reduce/3                                                    1       0.002       0.001     

Decimal.context/2                                                    1       0.003       0.002     
  Decimal.precision/3                                                1       0.003       0.002  <--
    :erlang.integer_to_list/1                                        1       0.001       0.001     

Enum.find/2                                                          1       0.002       0.001     
  Enum.find/3                                                        1       0.002       0.001  <--
    Enum.find_list/3                                                 1       0.001       0.001     

Enum.reduce/3                                                        2       0.002       0.002     
  Enum."-reduce/3-lists^foldl/2-0-"/3                                2       0.002       0.002  <--

Decimal.context/2                                                    1       0.002       0.001     
  Decimal.Context.get/0                                              1       0.002       0.001  <--
    Process.get/2                                                    1       0.001       0.001     

:fprof.apply_start_stop/4                                            1       0.001       0.001     
  :fprof."-apply_start_stop/4-after$^1/0-0-"/3                       1       0.001       0.001  <--
    :suspend                                                         1       0.000       0.000     

Process.put/2                                                        1       0.001       0.001     
  :erlang.put/2                                                      1       0.001       0.001  <--

Decimal.add/2                                                        1       0.001       0.001     
  :erlang.min/2                                                      1       0.001       0.001  <--

Decimal.precision/3                                                  1       0.001       0.001     
  :erlang.integer_to_list/1                                          1       0.001       0.001  <--

Decimal.Context.get/0                                                1       0.001       0.001     
  Process.get/2                                                      1       0.001       0.001  <--

Decimal.handle_error/4                                               1       0.001       0.001     
  List.wrap/1                                                        1       0.001       0.001  <--

Enum.find/3                                                          1       0.001       0.001     
  Enum.find_list/3                                                   1       0.001       0.001  <--

Decimal.add/2                                                        1       0.001       0.001     
  Decimal.add_sign/3                                                 1       0.001       0.001  <--

Decimal.add/2                                                        1       0.001       0.001     
  Decimal.add_align/4                                                1       0.001       0.001  <--

  :undefined                                                         0       0.000       0.000  <--
    :fprof.apply_start_stop/4                                        0       0.047       0.005     

:fprof."-apply_start_stop/4-after$^1/0-0-"/3                         1       0.000       0.000     
  :suspend                                                           1       0.000       0.000  <--
```

```
mix profile.eprof -e ApaExample.profile
Compiling 1 file (.ex)
Warmup...


Profile results of #PID<0.224.0>
#                                               CALLS     % TIME µS/CALL
Total                                              26 100.0   23    0.88
ApaExample.profile/0                                1  0.00    0    0.00
:erlang.min/2                                       1  0.00    0    0.00
Enum.find/3                                         1  0.00    0    0.00
Decimal.put_uniq/2                                  1  0.00    0    0.00
Decimal.context/1                                   1  0.00    0    0.00
Decimal.add_align/4                                 1  0.00    0    0.00
Decimal.Context.get/0                               1  0.00    0    0.00
:erlang.integer_to_list/1                           1  4.35    1    1.00
:erlang.put/2                                       1  4.35    1    1.00
Enum."-reduce/3-lists^foldl/2-0-"/3                 2  4.35    1    0.50
Enum.reduce/3                                       2  4.35    1    0.50
Enum.find_list/3                                    1  4.35    1    1.00
Enum.find/2                                         1  4.35    1    1.00
anonymous fn/0 in :elixir_compiler_1.__FILE__/1     1  4.35    1    1.00
Process.put/2                                       1  4.35    1    1.00
Process.get/2                                       1  4.35    1    1.00
List.wrap/1                                         1  4.35    1    1.00
Decimal.precision/3                                 1  4.35    1    1.00
Decimal.handle_error/4                              1  4.35    1    1.00
Decimal.add_sign/3                                  1  4.35    1    1.00
Decimal.Context.set/1                               1  4.35    1    1.00
Decimal.context/2                                   1  8.70    2    2.00
:erlang.apply/2                                     1 13.04    3    3.00
Decimal.add/2                                       1 17.39    4    4.00

Profile done over 24 matching functions
```



## Apa.add() 
```
mix profile.fprof -e ApaExample.profile --callers --details
Warmup...
Reading trace data...

End of trace!
Processing data...
Creating output...
Done!

                                                                   CNT    ACC (ms)    OWN (ms)     
Total                                                                5       0.012       0.012     

:undefined                                                           0       0.012       0.006     
  :fprof.apply_start_stop/4                                          0       0.012       0.006  <--
    anonymous fn/0 in :elixir_compiler_1.__FILE__/1                  1       0.004       0.002     
    :fprof."-apply_start_stop/4-after$^1/0-0-"/3                     1       0.002       0.002     

:fprof.apply_start_stop/4                                            1       0.004       0.002     
  anonymous fn/0 in :elixir_compiler_1.__FILE__/1                    1       0.004       0.002  <--
    ApaExample.profile/0                                             1       0.002       0.001     

:fprof.apply_start_stop/4                                            1       0.002       0.002     
  :fprof."-apply_start_stop/4-after$^1/0-0-"/3                       1       0.002       0.002  <--
    :suspend                                                         1       0.000       0.000     

anonymous fn/0 in :elixir_compiler_1.__FILE__/1                      1       0.002       0.001     
  ApaExample.profile/0                                               1       0.002       0.001  <--
    ApaAdd.bc_add_apa_number/2                                       1       0.001       0.001     

ApaExample.profile/0                                                 1       0.001       0.001     
  ApaAdd.bc_add_apa_number/2                                         1       0.001       0.001  <--

  :undefined                                                         0       0.000       0.000  <--
    :fprof.apply_start_stop/4                                        0       0.012       0.006     

:fprof."-apply_start_stop/4-after$^1/0-0-"/3                         1       0.000       0.000     
  :suspend                                                           1       0.000       0.000  <--

----------------------------------------------------------------------------------------------------
<0.93.0>                                                             5                   0.012     


:undefined                                                           0       0.012       0.006     
  :fprof.apply_start_stop/4                                          0       0.012       0.006  <--
    anonymous fn/0 in :elixir_compiler_1.__FILE__/1                  1       0.004       0.002     
    :fprof."-apply_start_stop/4-after$^1/0-0-"/3                     1       0.002       0.002     

:fprof.apply_start_stop/4                                            1       0.004       0.002     
  anonymous fn/0 in :elixir_compiler_1.__FILE__/1                    1       0.004       0.002  <--
    ApaExample.profile/0                                             1       0.002       0.001     

:fprof.apply_start_stop/4                                            1       0.002       0.002     
  :fprof."-apply_start_stop/4-after$^1/0-0-"/3                       1       0.002       0.002  <--
    :suspend                                                         1       0.000       0.000     

anonymous fn/0 in :elixir_compiler_1.__FILE__/1                      1       0.002       0.001     
  ApaExample.profile/0                                               1       0.002       0.001  <--
    ApaAdd.bc_add_apa_number/2                                       1       0.001       0.001     

ApaExample.profile/0                                                 1       0.001       0.001     
  ApaAdd.bc_add_apa_number/2                                         1       0.001       0.001  <--

  :undefined                                                         0       0.000       0.000  <--
    :fprof.apply_start_stop/4                                        0       0.012       0.006     

:fprof."-apply_start_stop/4-after$^1/0-0-"/3                         1       0.000       0.000     
  :suspend                                                           1       0.000       0.000  <--
```

```
mix profile.eprof -e ApaExample.profile
Compiling 1 file (.ex)
Warmup...


Profile results of #PID<0.224.0>
#                                               CALLS     % TIME µS/CALL
Total                                               4 100.0    5    1.25
anonymous fn/0 in :elixir_compiler_1.__FILE__/1     1  0.00    0    0.00
ApaExample.profile/0                                1 20.00    1    1.00
ApaAdd.bc_add_apa_number/2                          1 20.00    1    1.00
:erlang.apply/2                                     1 60.00    3    3.00

Profile done over 4 matching functions
```
