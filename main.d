import std;
import core.bitop;

// dfmt off
ulong MAX = 100_100, MOD = 1_000_000_007, INF = 1_000_000_000_000;
alias sread = () => readln.chomp();
alias lread(T = long) = () => readln.chomp.to!(T);
alias aryread(T = long) = () => readln.split.to!(T[]);
void aryWrite(T = long)(T[] ary){ ary.map!(x => x.text()).join(' ').writeln(); }
alias Pair = Tuple!(long, "H", long, "W", long, "cost");
alias PQueue(T, alias less = "a>b") = BinaryHeap!(Array!T, less);
// dfmt on

void main()
{
    auto s = lread();
    auto dp = new long[](s + 1);
    foreach (i; iota(3, s + 1))
    {
        dp[i] += 1;

        foreach (j; iota(i))
        {
            if (i - j >= 3)
            {
                dp[i] += dp[j];
                dp[i] %= MOD;
            }
        }
        dp[i] %= MOD;
    }
    // dp.writeln();
    dp[s].writeln();
}

void scan(TList...)(ref TList Args)
{
    auto line = readln.split();
    foreach (i, T; TList)
    {
        T val = line[i].to!(T);
        Args[i] = val;
    }
}
