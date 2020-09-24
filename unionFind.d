import std;

class UnionFind
{
    long n;
    long[] par;

    this(long init)
    {
        n = init;
        par = iota(n).array();
    }

    long root(long x)
    {
        if (par[x] == x)
            return x;
        else
            return par[x] = root(par[x]);
    }

    void unit(long x, long y)
    {
        if (root(x) != root(y))
            par[root(x)] = root(y);
    }

    bool same(long x, long y)
    {
        return (root(x) == root(y));
    }
}
