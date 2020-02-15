%%-----------------------------------------------------------------------------
%% @copyright (C) 2019, Matthew Pope
%% @author Matthew Pope
%% @doc Interface for the xor16 filter.
%%
%% Shorthand for the `exor_filter' module.  For indepth documentation, see
%% that module.
%%
%% Example usage:
%% ```
%% Filter = xor16:new(["cat", "dog", "mouse"]),
%% true   = xor16:contain(Filter, "cat"),
%% false  = xor16:contain(Filter, "goose"),
%% ok     = xor16:free(Filter).
%% '''
%% @end
%%-----------------------------------------------------------------------------
-module(xor16).

-export([
    new/1,
    new/2,
    new_buffered/1,
    new_buffered/2,
    contain/2,
    contain/3,
    free/1,
    to_bin/1,
    from_bin/1,
    from_bin/2
]).

%%-----------------------------------------------------------------------------
%% @doc Initializes the xor filter, and runs the default hash function on
%% each of the elements in the list.  This should be fine for the general case.
%% @end
%%-----------------------------------------------------------------------------
-spec new(list()) -> {reference(), atom()} | {error, atom()}.

new(List) ->
    exor_filter:xor16(List).


%%-----------------------------------------------------------------------------
%% @doc Initializes the xor filter, and runs the specified hash on each of 
%% the elements in the list.  
%%
%% The option `default_hash' uses the `erlang:phash2/1' function.
%% The option `none' is for prehashed data.
%% A fun can be passed that will be applied to each element.
%% @end
%%-----------------------------------------------------------------------------
-spec new(list(), atom() | fun()) -> 
   {reference(), atom() | fun()} | {error, atom()}.

new(List, HashFunction) ->
    exor_filter:xor16(List, HashFunction).


%%-----------------------------------------------------------------------------
%% @doc Initializes the xor filter, and runs the default hash function on
%% each of the elements in the list.  This is the buffered version, meant for
%% large filters.
%% @end
%%-----------------------------------------------------------------------------
-spec new_buffered(list()) -> {reference(), atom()} | {error, atom()}.

new_buffered(List) ->
    exor_filter:xor16_buffered(List).


%%-----------------------------------------------------------------------------
%% @doc Initializes the xor filter, and runs the default hash function on
%% each of the elements in the list.  This is the buffered version, meant for
%% large filters.  See the `xor8:new/2' or `exor_filter:xor8_new/2' funtions
%% for more indepth documentaiton.
%% @end
%%-----------------------------------------------------------------------------
-spec new_buffered(list(), atom() | fun()) 
   -> {reference(), atom() | fun()} | {error, atom()}.

new_buffered(List, HashFunction) ->
    exor_filter:xor16_buffered(List, HashFunction).


%%-----------------------------------------------------------------------------
%% @doc Tests to see if the passed argument is in the filter.  The first
%% argument must be the pre-initialized filter.
%% @end
%%-----------------------------------------------------------------------------
-spec contain({reference(), atom() | fun()}, term()) -> true | false.

contain(Filter, Key) ->
    exor_filter:xor16_contain(Filter, Key).


%%-----------------------------------------------------------------------------
%% @doc Tests to see if the passed argument is in the filter.  The first
%% argument must be the pre-initialized filter.
%%
%% Will return the third argument if the element doesn't exist in the filter.
%% @end
%%-----------------------------------------------------------------------------
-spec contain({reference(), atom() | fun()}, term(), any()) -> true | any().

contain(Filter, Key, ReturnValue) ->
    exor_filter:xor16_contain(Filter, Key, ReturnValue).

%%-----------------------------------------------------------------------------
%% @doc Frees the memory of the filter.  These can be large structures, so it
%% is recommended that this is called for cleanup.
%%
%% Returns `ok'.
%% @end
%%-----------------------------------------------------------------------------
-spec free({reference(), any()}) -> ok.

free(Filter) ->
    exor_filter:xor16_free(Filter).


to_bin(Filter) ->
    exor_filter:xor16_to_bin(Filter).

from_bin(Filter) ->
    exor_filter:xor16_from_bin(Filter).

from_bin(Filter, Hash) ->
    exor_filter:xor16_from_bin(Filter, Hash).
