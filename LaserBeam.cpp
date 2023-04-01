
#include<iostream>
#include<cmath>
using namespace std;

class Point
{
	private:
	double x,y;
	public:
	Point() //default constructor
	{
		x = 0.0;
		y = 0.0;
	}
	Point(double a, double b) //parameterized constructor
	{
		x = a;
		y = b;
	}
	//setters:
	void setX(double a)
	{
		x = a;
	}
	void setY(double b)
	{
		y = b;
	}
	//getters:
	double getX()
	{
		return x;
	}
	double getY()
	{
		return y;
	}
	//length of the vector pointing to it
	double Length()
	{
		return sqrt(pow(x,2) + pow(y,2));
	}
	void Normalize() //normalizes the vector to that point
	{
		this->setX(this->getX()/(this->Length()));
		this->setY(this->getY()/(this->Length()));
	}
};

Point tangentv(Point P); 
Point normalv(Point P);
double FindBiggestRoot(double poly[3]);

int main()
{
	int counter = 1;
	bool inside = true;
	Point start(0,10.1); //starting point of the ray
	Point hit(1.4,-9.6); //first known hit of the ray
	Point reflection;
	Point symmetric;
	while(inside)
	{
		//STEP 1: Find the reflection direction using the symmetric  point of start with respect to the normal line
		double t = (tangentv(hit).getY()*(hit.getX()-start.getX()) - tangentv(hit).getX()*(hit.getY()-start.getY()))/(tangentv(hit).getX()*normalv(hit).getY() - tangentv(hit).getY()*normalv(hit).getX());
		cout << t << endl;
		symmetric.setX(2*(hit.getX() + t*normalv(hit).getX()) - start.getX());
		symmetric.setY(2*(hit.getY() + t*normalv(hit).getY()) - start.getY());
		reflection.setX(symmetric.getX()-hit.getX());
		reflection.setY(symmetric.getY()-hit.getY());
		//STEP 2 : Find the next intersection point in the ellipse with the reflected ray direction 
		double Poly[3] = { 4*pow(reflection.getX(),2) + pow(reflection.getY(), 2),  8*hit.getX()*reflection.getX() + 2*hit.getY()*reflection.getY(), 4*pow(hit.getX(), 2) + pow(hit.getY(), 2) -100};
		double root = FindBiggestRoot(Poly);
		//STEP 3 : Update start and hit points and check exit conditions:
		start = hit;
		hit.setX(hit.getX() + root*reflection.getX());
		hit.setY(hit.getY() + root*reflection.getY());
		if( (abs(hit.getX()) <= 0.01) && (hit.getY() >0) )
		{
			inside = false;
		}else
		{
			counter++;
		}
		cout << counter << endl;
		cout << "(" << hit.getX() << "," << hit.getY() << ")" << endl;
		/*if(counter >100){ //testing
			inside = false;
		}
		*/
	}

	return 0;
}

Point tangentv(Point P)
{
	Point t(P.getY(),-4.0*P.getX());
	t.Normalize();
	return t;
}
Point normalv(Point P)
{
	Point n(-4.0*P.getX(), (-1.0)*P.getY());
	n.Normalize();
	return n;
}
double FindBiggestRoot(double poly[3]) {
    double a = poly[0];
    double b = poly[1];
    double c = poly[2];
    double discriminant = b * b - 4 * a * c;
    double root1 = (-b + sqrt(discriminant)) / (2 * a);
    double root2 = (-b - sqrt(discriminant)) / (2 * a);
    if (abs(root1) > abs(root2)) {
        return root1;
    } else {
        return root2;
    }
}
