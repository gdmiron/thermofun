#ifndef GASPRSV
#define GASPRSV

#include "Solvent/Reaktoro/WaterThermoStateUtils.hpp"

namespace ThermoFun {

auto thermoPropertiesGasPRSV(Reaktoro_::Temperature t, Reaktoro_::Pressure p, Substance subst, ThermoPropertiesSubstance tps) -> ThermoPropertiesSubstance;

}


#endif // GASPRSV
