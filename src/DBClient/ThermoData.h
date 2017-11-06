#ifndef THERMODATA_H
#define THERMODATA_H

// C++ includes
#include <memory>

// ThermoFun includes
#include "formuladata.h"

namespace ThermoFun {


class ThermoDataAbstract
{
public:

    ThermoDataAbstract( const string &name, const string &query, const vector<string> &paths, const vector<string> &headers, const vector<string> &names );

    boost::shared_ptr<bsonio::TDBGraph> getDB() const;

    string getName() const;
    string getQuery() const;
    vector<string> getFieldPaths() const;
    void setFieldPaths(const vector<string> &value);
    vector<string> getDataHeaders() const;
    void setDataHeaders(const vector<string> &value);
    vector<string> getDataNames() const;
    void setDataNames(const vector<string> &value);

    // load values function
    /// Extract data connected to ReactionSet
//    virtual bsonio::ValuesTable  loadRecordsValues( const string& idReactionSet ) = 0;
    /// Extract data by condition
    virtual bsonio::ValuesTable  loadRecordsValues( const string& query, int sourcetdb,
                                                    const vector<ElementKey>& elements = {} ) = 0;
    /// Get Elements list from record
    virtual map<ElementKey, double> getElementsList( const string& idrec ) = 0;

    void setDB(const boost::shared_ptr<bsonio::TDBGraph> &value);

    protected:

    /// Test all elements from formula exist into list
    static bool testElementsFormula( const string& aformula, const vector<ElementKey>& elements );

    /// Build ids list connected to idInVertex by edge
    vector<string> getOutVertexIds(const string& edgeLabel, const string& idInVertex );

    /// Build ids list connected to idInVertex by edge, record edgesIds
    vector<string> getOutVertexIds(const string& edgeLabel, const string& idInVertex,  vector<string> &edgesIds);

private:
    struct Impl;

    std::shared_ptr<Impl> pimpl;

};


}

#endif // THERMODATA_H
