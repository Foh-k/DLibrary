import std;

long MOD = 1_000_000_007;

// modありの和
long addMod(long[] ary, long mod = MOD)
{
    long ret;
    foreach (e; ary)
    {
        ret += e;
        ret %= mod;
    }
    return ret;
}

// modありの積
long prodMod(long[] ary, long mod = MOD)
{
    long ret;
    foreach (e; ary)
    {
        ret *= e;
        ret %= mod;
    }
    return ret;
}

// modありの差
long subMod(long[] ary, long mod = MOD)
{
    long ret;
    foreach (e; ary)
    {
        ret -= e;
        if (ret < 0)
            ret += mod;
        ret %= mod;
    }
    return ret;
}

// modでの逆元の計算
long modInv(long n, long mod = MOD)
{
    long b = mod, s = 1, t = 0;
    while (b)
    {
        auto tmp = n / b;
        // ユークリッドの互除法
        n -= b * tmp;
        swap(n, b);
        // 拡張ユークリッドの互除法
        s -= t * tmp;
        swap(s, t);
    }
    s %= mod;
    if (s < 0)
        s += mod;

    return s;
}

// modありの割り算,逆元を利用
long devMod(long a, long b, long mod = MOD)
{
    auto b_inv = b.modInv(mod);
    return (a * b_inv) % mod;
}

// 累積二乗法
long powerMod(long a, long n, long mod = MOD)
{
    long ret = 1;
    while (n)
    {
        if (n % 2)
        {
            ret *= a;
            ret %= mod;
        }
        a^^=2;
        a %= mod;
        n >>= 1;
    }
    return ret % mod;
}

// 階乗のmod
long factMod(long a, long mod = MOD)
{
    long ret = 1;
    while (a)
    {
        ret *= a;
        ret %= mod;
        a--;
    }
    return ret % mod;
}

// fermatの小定理を用いた逆元計算を行うcombinationの計算
// 計算量はO(log mod)
long fermat_combination_mod(long n, long r, long mod = MOD)
{
    long a = n.factorial_mod(mod);
    long b = (n - r).factorial_mod(mod);
    long c = r.factorial_mod(mod);
    long b_inv = b.power_mod(mod - 2, mod);
    long c_inv = c.power_mod(mod - 2, mod);
    return (((a * b_inv) % mod) * c_inv) % mod;
}

// 拡張ユークリッドの互除法を用いた逆元計算を行うcombinationの計算
long SIZE = 500_100;
long[SIZE] fac;
long[SIZE] inv;
long[SIZE] finv;

void init_comb_table(long mod = MOD)
{
    fac[0] = fac[1] = 1;
    finv[0] = finv[1] = 1;
    inv[1] = 1;
    foreach (i; 2 .. fac.length)
    {
        fac[i] = fac[i - 1] * i % mod;
        inv[i] = mod - inv[mod % i] * (mod / i) % mod;
        finv[i] = finv[i - 1] * inv[i] % mod;
    }
}

long euclid_combination_mod(long n, long r, long mod = MOD)
{
    if (n < k)
        return 0;
    if (n < 0 || k < 0)
        return 0;
    return fac[n] * (finv[k] * finv[n - k] % mod) % mod;
}

// nが大きくkが小さい場合のcombationの計算
// nCk = ((n - k + 1) / k) * nCk-1の漸化式を利用


// フェルマーの小定理を利用した逆元計算
// 原理理解してるし残す必要はほぼ感じないけど一応
long fermat_inv(long a, long mod = MOD)
{
    return a.power_mod(mod - 2);
}

// lcmのmod、使うかは疑問だが書くのに結構苦労したので残しておく
auto lcm_mod(T)(T[] ary, T limit = MAX, long mod = MOD)
{
    // 素因数の形で保持
    auto lcm_table = new T[](limit + 1);
    auto minFactor = new long[](limit + 1);
    // 素因数分解には minFactor[i] = iに含まれる最小の素因数 とする配列を利用
    // この配列はエラトステネスの篩を使うことで高速に求められる
    // minFactorの設定
    {
        auto isPrime = new bool[](limit + 1);
        isPrime[] = true;
        isPrime[0] = isPrime[1] = false;
        foreach (i; iota(2, limit + 1))
        {
            if (isPrime[i])
            {
                foreach (j; iota(i, limit + 1, i))
                {
                    if (isPrime[j])
                    {
                        minFactor[j] = i;
                        isPrime[j] = false;
                    }
                }
            }
        }
    }
    // minFactor[]を利用した素因数分解とlcm_tableの設定
    foreach (e; ary)
    {
        long[long] prime_factor;
        while (minFactor[e])
        {
            if (minFactor[e] in prime_factor)
                prime_factor[minFactor[e]]++;
            else
                prime_factor[minFactor[e]] = 1;

            e /= minFactor[e];
        }
        foreach (key, value; prime_factor)
            lcm_table[key] = max(value, lcm_table[key]);
    }
    // lcmの計算(mod)
    long ret = 1;
    foreach (i, e; lcm_table)
    {
        if (e)
        {
            ret *= power_mod(i, e);
            ret %= mod;
        }
    }
    return ret;
}

void main()
{
}
