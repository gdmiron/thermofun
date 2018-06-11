#include "ThermoSetData.h"

using namespace jsonio;

namespace ThermoFun {

const DBQueryData datsetQuery( "{\"_label\": \"thermodataset\" }", DBQueryData::qTemplate );
const vector<string> datsetFieldPaths       = {"properties.symbol","properties.name", "properties.type","_id"};
const vector<string> datsetColumnHeaders    = {"symbol", "name", "type"};
const vector<string> datsetDataNames        = {"symbol", "name", "type", "_id"};

struct ThermoSetData::Impl
{
    ValuesTable valuesTable;

    Impl( )
    {
    }

};

ThermoSetData::ThermoSetData( const TDataBase* adbconnect )
    : AbstractData( adbconnect, "VertexThermoDataSet", datsetQuery,
                    datsetFieldPaths, datsetColumnHeaders, datsetDataNames), pimpl(new Impl())
{ }

ThermoSetData::ThermoSetData(const ThermoSetData& other)
: AbstractData(other), pimpl(new Impl(*other.pimpl))
{}

auto ThermoSetData::operator=(ThermoSetData other) -> ThermoSetData&
{
    pimpl = std::move(other.pimpl);
    return *this;
}

ThermoSetData::~ThermoSetData()
{}

set<ElementKey> ThermoSetData::getElementsList( const string& idSubstance )
{

}

ValuesTable ThermoSetData::loadRecordsValues( const DBQueryData& aquery,
                    int sourcetdb, const vector<ElementKey>& elements )
{

}

ValuesTable ThermoSetData::loadRecordsValues( const string& idReactionSet )
{

}

auto ThermoSetData::idRecordFromSymbol (const string &symbol) -> string
{
    vector<string> ids;
    string qrJson = "FOR u  IN thermodatasets ";
           qrJson += "FILTER u.properties.symbol == \""+symbol+"\" ";
           qrJson += "RETURN u._id";
    if ( ids.size() == 1)
        return ids[0];
    else return "";
}

vector<string> ThermoSetData::selectGiven( const vector<string>& idThermoDataSets, bool  )
{
    auto  resMatr = getDB()->loadRecords(idThermoDataSets, getDataFieldPaths());

    vector<string> thermoSymbols;
    for (const auto& subitem : resMatr)
      thermoSymbols.push_back(subitem[getDataName_DataIndex()["symbol"]]);

    pimpl->valuesTable = move(resMatr);
    return thermoSymbols;
}


// Visit  all linked Vertexes
void ThermoSetData::traverceVertexes( const string& idThermoDataSet, jsonio::GraphElementFunction afunc )
{
    string qrAQL = "FOR v,e  IN 1..5 INBOUND '" + idThermoDataSet + "' \n";
           qrAQL +=  ThermoDataSetQueryEdges;
           qrAQL +=  "\n  SORT v._label ";
           qrAQL +=  " \n RETURN DISTINCT  v";

    DBQueryData query( qrAQL, DBQueryData::qAQL );
    vector<string> resultsQuery;
    getDB()->runQuery( query,  {}, resultsQuery );

    for( auto result: resultsQuery )
        afunc( true, result );
}

// Visit  all linked Edges
void ThermoSetData::traverceEdges( const string& idThermoDataSet, jsonio::GraphElementFunction afunc )
{
    string qrAQL = "FOR v,e  IN 1..5 INBOUND '" + idThermoDataSet + "' \n";
           qrAQL +=  ThermoDataSetQueryEdges;
           qrAQL +=  "\n  SORT e._label ";
           qrAQL +=  " \n RETURN DISTINCT  e";

    DBQueryData query( qrAQL, DBQueryData::qAQL );
    vector<string> resultsQuery;
    getDB()->runQuery( query,  {}, resultsQuery );

    for( auto result: resultsQuery )
        afunc( false, result );
}



}
