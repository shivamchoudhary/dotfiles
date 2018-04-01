#include <iterator>
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>
#include <map>
#include <ctime>
#include <iomanip>
#include <chrono>
using namespace std;
class CSVRow
{
    public:
        std::string const& operator[](std::size_t index) const
        {
            return m_data[index];
        }
        std::size_t size() const
        {
            return m_data.size();
        }
        void readNextRow(std::istream& str)
        {
            std::string         line;
            std::getline(str, line);

            std::stringstream   lineStream(line);
            std::string         cell;

            m_data.clear();
            while(std::getline(lineStream, cell, ','))
            {
                m_data.push_back(cell);
            }
            // This checks for a trailing comma with no data after it.
            if (!lineStream && cell.empty())
            {
                // If there was a trailing comma then add an empty element.
                m_data.push_back("");
            }
        }
    private:
        std::vector<std::string>    m_data;
};

std::istream& operator>>(std::istream& str, CSVRow& data)
{
    data.readNextRow(str);
    return str;
}   
class Solution {
    private:
        std::string fname;
         
        /* Value from the csv file*/
        struct Value {
            std::string person;
            std::string carName;
            float milesDriven;
            int gallonsFilled;
            std::string date;
        };

        std::map<std::string, std::vector<struct Value>> car_map;
        /* Output */ 
        struct output {
            int miles;
            float gallons;
        };
        std::map<std::string, std::vector<output>> out;
    
    public:
        Solution(std::string name) : fname(name) {};
        void parse(void);
        void GetMPG(std::string name, std::string start_date, std::string end_date);
};


void Solution::parse() {
    std::ifstream file(fname);
    CSVRow row;
    /* Skip header */
    file>>row;
    while(file >> row) {
        Value v;
        v.person = row[0];
        v.carName = row[1];
        v.milesDriven = std::stoi(row[2]);
        v.gallonsFilled =std::stof(row[3]);
        v.date = row[4];
        car_map[v.person].push_back(v);
    }
};

void Solution::GetMPG(std::string name, std::string start_date, std::string end_date) {
    
    for (auto&x: car_map) {
        if (x.first == name) {
            
            for (auto &y:x.second) {
                if (y.date > start_date && y.date<end_date) {
                    struct output o;
                    o.miles = y.milesDriven;
                    o.gallons = y.gallonsFilled;
                    out[y.carName].push_back(o);
                }
            }
        }
        
    }
    for (auto const&z:out) {
        float mpg =0;
        float gallonsTotal = 0;
        int milesTotal =0;
        std::cout<<"Person Name: " <<name<< " Car Name: "<<z.first<<"MPG: ";
        for (auto const y:z.second) {
            gallonsTotal += y.gallons;
            milesTotal +=y.miles;
        } 
        std::cout<<milesTotal/gallonsTotal<<std::endl;
    }
}
int main()
{
    
    Solution s("cars.csv");
    s.parse();
    // s.GetMPG("A", "04/20/2018","06/30/2018");
    s.GetMPG("A", "04/20/2018","06/19/2018");
    return 0;
    /* std::string personName="A"; */
    // std::string start_date = "04/20/2018";
    // std::string end_date = "06/30/2018";
    // for(auto const &x :car_map){ 
        // if (x.first==personName) {
            
            // for (auto &y: x.second) {
                // if (y.date > start_date && y.date < end_date) {
                    // std::cout<<y.milesDriven<<std::endl;
                    // struct output o;
                    // o.miles = y.milesDriven;
                    // o.gallons = y.gallonsFilled;
                    // out[y.carName].push_back(o); 
                // }
            // }
        // }
        // // for (auto const&y:x.second) {
                // // cout<<y.carName<<std::endl;
            // // }
        // }

    // for (auto const&z: out) {
        // std::cout<<z.first<<std::endl;
        // float mpg = 0;
        // float gallonstotal = 0;
        // int milestotal = 0;
        // for (auto const&y: z.second) {
            // gallonstotal +=y.gallons;
            // milestotal +=y.miles;

        // }
        // std::cout<<"MPG" <<milestotal/gallonstotal<<std::endl;
    /* } */
} 
