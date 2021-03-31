// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// mod
double mod(double x, int base);
RcppExport SEXP _har18_mod(SEXP xSEXP, SEXP baseSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< double >::type x(xSEXP);
    Rcpp::traits::input_parameter< int >::type base(baseSEXP);
    rcpp_result_gen = Rcpp::wrap(mod(x, base));
    return rcpp_result_gen;
END_RCPP
}
// get_index
double get_index(NumericVector& x, int index, int offset);
RcppExport SEXP _har18_get_index(SEXP xSEXP, SEXP indexSEXP, SEXP offsetSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector& >::type x(xSEXP);
    Rcpp::traits::input_parameter< int >::type index(indexSEXP);
    Rcpp::traits::input_parameter< int >::type offset(offsetSEXP);
    rcpp_result_gen = Rcpp::wrap(get_index(x, index, offset));
    return rcpp_result_gen;
END_RCPP
}
// cosine_similarity_cpp
double cosine_similarity_cpp(NumericVector& x, NumericVector& template_, int offset);
RcppExport SEXP _har18_cosine_similarity_cpp(SEXP xSEXP, SEXP template_SEXP, SEXP offsetSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector& >::type x(xSEXP);
    Rcpp::traits::input_parameter< NumericVector& >::type template_(template_SEXP);
    Rcpp::traits::input_parameter< int >::type offset(offsetSEXP);
    rcpp_result_gen = Rcpp::wrap(cosine_similarity_cpp(x, template_, offset));
    return rcpp_result_gen;
END_RCPP
}
// sweep_template_cpp
NumericVector sweep_template_cpp(NumericVector& x, NumericVector& template_);
RcppExport SEXP _har18_sweep_template_cpp(SEXP xSEXP, SEXP template_SEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector& >::type x(xSEXP);
    Rcpp::traits::input_parameter< NumericVector& >::type template_(template_SEXP);
    rcpp_result_gen = Rcpp::wrap(sweep_template_cpp(x, template_));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_har18_mod", (DL_FUNC) &_har18_mod, 2},
    {"_har18_get_index", (DL_FUNC) &_har18_get_index, 3},
    {"_har18_cosine_similarity_cpp", (DL_FUNC) &_har18_cosine_similarity_cpp, 3},
    {"_har18_sweep_template_cpp", (DL_FUNC) &_har18_sweep_template_cpp, 2},
    {NULL, NULL, 0}
};

RcppExport void R_init_har18(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}