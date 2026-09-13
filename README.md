# Ball and Beam Control System

A MATLAB/Simulink-based control system project for modeling, designing, tuning, and evaluating a controller for a **Ball and Beam** plant.

---

## 1. System Modeling

The Ball and Beam system was mathematically modeled and simplified to a double-integrator plant:

$$
G(s)=\frac{K_b}{s^2}
$$

where

$$
K_b=\frac{5g}{7}\approx 7.0071
$$

The resulting plant has **two poles at the origin**, representing an undamped system with integrating behavior.

---

## 2. Controller Design

To achieve **zero steady-state error for step inputs**, a compensator with integral action was designed:

$$
C(s)=\frac{K(s+z_1)(s+z_2)}{s(s+p)}
$$

The final controller parameters were tuned and verified through MATLAB Control System Designer.

### Final Controller Parameters

| Parameter       |         Value |
| --------------- | ------------: |
| Gain, \(K\)     |  **0.338461** |
| Zero 1, \(z_1\) | **−0.014631** |
| Zero 2, \(z_2\) | **−0.010673** |
| Integrator      |         **0** |
| Pole, \(p\)     | **−1.850413** |

The controller was selected to provide a balance between transient response, stability margins, bandwidth, and control effort.

---

## 3. Performance Evaluation

The final closed-loop system was evaluated in both the **time domain** and **frequency domain**.

### Time-Domain Performance

| Metric                |      Result | Requirement | Status |
| --------------------- | ----------: | ----------: | :----: |
| Overshoot \(M_p\)     |  **11.72%** |    ≤ 10–15% | ✅ PASS |
| Rise Time \(T_r\)     | **1.179 s** |       1–3 s | ✅ PASS |
| Settling Time \(T_s\) | **4.345 s** |       ≤ 5 s | ✅ PASS |
| Steady-State Error    |       **0** |           0 | ✅ PASS |

### Frequency-Domain Performance

| Metric              |          Result | Requirement |     Status    |
| ------------------- | --------------: | ----------: | :-----------: |
| Phase Margin        |      **57.93°** |      45–60° |     ✅ PASS    |
| Bandwidth           | **1.779 rad/s** |   1–5 rad/s |     ✅ PASS    |
| Control Effort Peak |       **0.353** |       < 2–3 |     ✅ PASS    |
| Gain Margin         |   **−46.23 dB** |      ≥ 6 dB | ⚠️ LIMITATION |

### Stability

The closed-loop poles were verified to lie in the **left half of the complex plane**, confirming asymptotic stability of the designed closed-loop system.

> **Note:** The negative gain margin is a known limitation of the design and is associated with the three-integration open-loop structure. This limitation was documented during the controller evaluation.

---

## 4. MATLAB & Simulink Assets

The project includes MATLAB scripts, Simulink models, controller-design sessions, and supporting documentation.

### MATLAB Scripts

* `ballAndBeamScript.m`
  Main modeling and simulation script.

* `transferFunctionBallAndBeamDetailed.m`
  Detailed transfer-function development and analysis.

* `ExtractPIDGainsFromSecondOrderTransferFunction.m`
  Utility for extracting equivalent PID-related parameters from the transfer function.

### Simulink Models

* `Feedback_Configuration_1.slx`
* `pi_seudoControllerBallandBeam.slx`
* Associated backup and legacy model files.

### Design

* `ControlSystemDesignerSession2designs.mat`
  MATLAB Control System Designer session containing controller-design work.

---

## 5. Team Contributions

* **Member 1:** Mathematical modeling and derivation of the plant transfer function.
* **Member 2 (My Role):** Controller design, parameter tuning, and stability/performance analysis.
* **Member 3:** Simulink implementation, simulations, MATLAB scripts, and report preparation.

---

## 6. Final Outcome

The final controller successfully achieved the primary design objectives:

* ✅ Stable closed-loop response
* ✅ Zero steady-state error
* ✅ Acceptable overshoot
* ✅ Fast rise time
* ✅ Settling time below the required limit
* ✅ Adequate phase margin
* ✅ Required bandwidth
* ✅ Low control effort

The **gain margin requirement was not satisfied**, primarily due to the multiple-integrator structure of the open-loop system. This was identified and documented as a known limitation of the final controller.

Overall, the project demonstrates the complete control-system workflow:

**Mathematical Modeling → Plant Definition → Controller Design → Parameter Tuning → MATLAB/Simulink Implementation → Stability Analysis → Performance Verification**

---

_Last updated: 13-09-2026_
