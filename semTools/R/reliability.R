### Sunthud Pornprasertmanit , Yves Rosseel
### Last updated: 9 March 2018



#' Calculate reliability values of factors
#'
#' Calculate reliability values of factors by coefficient omega
#'
#' The coefficient alpha (Cronbach, 1951) can be calculated by
#'
#' \deqn{ \alpha = \frac{k}{k - 1}\left[ 1 - \frac{\sum^{k}_{i = 1}
#' \sigma_{ii}}{\sum^{k}_{i = 1} \sigma_{ii} + 2\sum_{i < j} \sigma_{ij}}
#' \right],}
#'
#' where \eqn{k} is the number of items in a factor, \eqn{\sigma_{ii}} is the
#' item \emph{i} observed variances, \eqn{\sigma_{ij}} is the observed
#' covariance of items \emph{i} and \emph{j}.
#'
#' The coefficient omega (Bollen, 1980; see also Raykov, 2001) can be
#' calculated by
#'
#' \deqn{ \omega_1 =\frac{\left( \sum^{k}_{i = 1} \lambda_i \right)^{2}
#' Var\left( \psi \right)}{\left( \sum^{k}_{i = 1} \lambda_i \right)^{2}
#' Var\left( \psi \right) + \sum^{k}_{i = 1} \theta_{ii} + 2\sum_{i < j}
#' \theta_{ij} }, }
#'
#' where \eqn{\lambda_i} is the factor loading of item \emph{i}, \eqn{\psi} is
#' the factor variance, \eqn{\theta_{ii}} is the variance of measurement errors
#' of item \emph{i}, and \eqn{\theta_{ij}} is the covariance of measurement
#' errors from item \emph{i} and \emph{j}.
#'
#' The second coefficient omega (Bentler, 1972, 2009) can be calculated by
#'
#' \deqn{ \omega_2 = \frac{\left( \sum^{k}_{i = 1} \lambda_i \right)^{2}
#' Var\left( \psi \right)}{\bold{1}^\prime \hat{\Sigma} \bold{1}}, }
#'
#' where \eqn{\hat{\Sigma}} is the model-implied covariance matrix, and
#' \eqn{\bold{1}} is the \eqn{k}-dimensional vector of 1. The first and the
#' second coefficients omega will have the same value when the model has simple
#' structure, but different values when there are (for example) cross-loadings
#' or method factors. The first coefficient omega can be viewed as the
#' reliability controlling for the other factors (like \eqn{\eta^2_partial} in
#' ANOVA). The second coefficient omega can be viewed as the unconditional
#' reliability (like \eqn{\eta^2} in ANOVA).
#'
#' The third coefficient omega (McDonald, 1999), which is sometimes referred to
#' hierarchical omega, can be calculated by
#'
#' \deqn{ \omega_3 =\frac{\left( \sum^{k}_{i = 1} \lambda_i \right)^{2}
#' Var\left( \psi \right)}{\bold{1}^\prime \Sigma \bold{1}}, }
#'
#' where \eqn{\Sigma} is the observed covariance matrix. If the model fits the
#' data well, the third coefficient omega will be similar to the
#' \eqn{\omega_2}. Note that if there is a directional effect in the model, all
#' coefficients omega will use the total factor variances, which is calculated
#' by \code{\link[lavaan]{lavInspect}(object, "cov.lv")}.
#'
#' In conclusion, \eqn{\omega_1}, \eqn{\omega_2}, and \eqn{\omega_3} are
#' different in the denominator. The denominator of the first formula assumes
#' that a model is congeneric factor model where measurement errors are not
#' correlated. The second formula accounts for correlated measurement errors.
#' However, these two formulas assume that the model-implied covariance matrix
#' explains item relationships perfectly. The residuals are subject to sampling
#' error. The third formula use observed covariance matrix instead of
#' model-implied covariance matrix to calculate the observed total variance.
#' This formula is the most conservative method in calculating coefficient
#' omega.
#'
#' The average variance extracted (AVE) can be calculated by
#'
#' \deqn{ AVE = \frac{\bold{1}^\prime
#' \textrm{diag}\left(\Lambda\Psi\Lambda^\prime\right)\bold{1}}{\bold{1}^\prime
#' \textrm{diag}\left(\hat{\Sigma}\right) \bold{1}}, }
#'
#' Note that this formula is modified from Fornell & Larcker (1981) in the case
#' that factor variances are not 1. The proposed formula from Fornell & Larcker
#' (1981) assumes that the factor variances are 1. Note that AVE will not be
#' provided for factors consisting of items with dual loadings. AVE is the
#' property of items but not the property of factors.
#'
#' Regarding categorical indicators, coefficient alpha and AVE are calculated
#' based on polychoric correlations. The coefficient alpha from this function
#' may be not the same as the standard alpha calculation for categorical items.
#' Researchers may check the \code{alpha} function in the \code{psych} package
#' for the standard coefficient alpha calculation.
#'
#' Item thresholds are not accounted for. Coefficient omega for categorical
#' items, however, is calculated by accounting for both item covariances and
#' item thresholds using Green and Yang's (2009, formula 21) approach. Three
#' types of coefficient omega indicate different methods to calculate item
#' total variances. The original formula from Green and Yang is equivalent to
#' \eqn{\omega_3} in this function. Green and Yang did not propose a method for
#' calculating reliability with a mixture of categorical and continuous
#' indicators, and we are currently unaware of an appropriate method.
#' Therefore, when \code{reliability} detects both categorical and continuous
#' indicators in the model, an error is returned. If the categorical indicators
#' load on a different factor(s) than continuous indicators, then reliability
#' can be calculated separately for those scales by fitting separate models and
#' submitting each to the \code{reliability} function.
#'
#'
#' @importFrom lavaan lavInspect
#' @param object The lavaan model object provided after running the \code{cfa},
#' \code{sem}, \code{growth}, or \code{lavaan} functions.
#' @return Reliability values (coefficient alpha, coefficients omega, average
#' variance extracted) of each factor in each group
#' @author Sunthud Pornprasertmanit (\email{psunthud@@gmail.com})
#'
#' Yves Rosseel (Ghent University; \email{Yves.Rosseel@@UGent.be})
#'
#' @seealso \code{\link{reliabilityL2}} for reliability value of a desired
#' second-order factor, \code{\link{maximalRelia}} for the maximal reliability
#' of weighted composite
#' @references
#' Bollen, K. A. (1980). Issues in the comparative measurement of
#' political democracy. \emph{American Sociological Review, 45}(3), 370--390.
#' Retrieved from \url{http://www.jstor.org/stable/2095172}
#'
#' Bentler, P. M. (1972). A lower-bound method for the dimension-free
#' measurement of internal consistency. \emph{Social Science Research, 1}(4),
#' 343--357. doi:10.1016/0049-089X(72)90082-8
#'
#' Bentler, P. M. (2009). Alpha, dimension-free, and model-based internal
#' consistency reliability. \emph{Psychometrika, 74}(1), 137--143.
#' doi:10.1007/s11336-008-9100-1
#'
#' Cronbach, L. J. (1951). Coefficient alpha and the internal structure of
#' tests. \emph{Psychometrika, 16}(3), 297--334. doi:10.1007/BF02310555
#'
#' Fornell, C., & Larcker, D. F. (1981). Evaluating structural equation models
#' with unobservable variables and measurement errors. \emph{Journal of
#' Marketing Research, 18}(1), 39--50. doi:10.2307/3151312
#'
#' Green, S. B., & Yang, Y. (2009). Reliability of summed item scores using
#' structural equation modeling: An alternative to coefficient alpha.
#' \emph{Psychometrika, 74}(1), 155--167. doi:10.1007/s11336-008-9099-3
#'
#' McDonald, R. P. (1999). \emph{Test theory: A unified treatment}. Mahwah, NJ:
#' Erlbaum.
#'
#' Raykov, T. (2001). Estimation of congeneric scale reliability using
#' covariance structure analysis with nonlinear constraints \emph{British
#' Journal of Mathematical and Statistical Psychology, 54}(2), 315--323.
#' doi:10.1348/000711001159582
#' @examples
#'
#' library(lavaan)
#'
#' HS.model <- ' visual  =~ x1 + x2 + x3
#'               textual =~ x4 + x5 + x6
#'               speed   =~ x7 + x8 + x9 '
#'
#' fit <- cfa(HS.model, data = HolzingerSwineford1939)
#' reliability(fit)
#'
#' @export
reliability <- function(object) {
	param <- lavInspect(object, "est")
	ngroup <- lavInspect(object, "ngroups")
	categorical <- length(lavNames(object, "ov.ord"))
	name <- names(param)
	if (ngroup == 1L) {
		ly <- param[name == "lambda"]
	} else {
		ly <- lapply(param, "[[", "lambda")
	}
	ps <- lavInspect(object, "cov.lv")
	if (ngroup == 1L) {
	  ps <- list(ps)
		te <- param[name == "theta"]
	} else {
		te <- lapply(param, "[[", "theta")
	}
	SigmaHat <- lavInspect(object, "cov.ov")
	if (ngroup == 1L) SigmaHat <- list(SigmaHat)
	threshold <- NULL
	if (ngroup == 1L) {
    S <- list(lavInspect(object, "sampstat")$cov)
	} else {
		S <- lapply(lavInspect(object, "sampstat"), function(x) x$cov)
	}
	if (categorical) threshold <- getThreshold(object)
	flag <- FALSE
	result <- list()
	for (i in 1:ngroup) {
		common <- (apply(ly[[i]], 2, sum)^2) * diag(ps[[i]])
		truevar <- ly[[i]] %*% ps[[i]] %*% t(ly[[i]])
		error <- rep(NA, length(common))
		alpha <- rep(NA, length(common))
		total <- rep(NA, length(common))
		omega1 <- omega2 <- omega3 <- rep(NA, length(common))
		impliedTotal <- rep(NA, length(common))
		avevar <- rep(NA, length(common))
		for (j in 1:length(common)) {
			index <- which(ly[[i]][,j] != 0)
			error[j] <- sum(te[[i]][index, index, drop = FALSE])
			sigma <- S[[i]][index, index, drop = FALSE]
			alpha[j] <- computeAlpha(sigma, length(index))
			total[j] <- sum(sigma)
			impliedTotal[j] <- sum(SigmaHat[[i]][index, index, drop = FALSE])
			faccontrib <- ly[[i]][,j, drop = FALSE] %*% ps[[i]][j,j, drop = FALSE] %*% t(ly[[i]][,j, drop = FALSE])
			truefac <- diag(faccontrib[index, index, drop = FALSE])
			commonfac <- sum(faccontrib[index, index, drop = FALSE])
			trueitem <- diag(truevar[index, index, drop = FALSE])
			erritem <- diag(te[[i]][index, index, drop = FALSE])
			if (sum(abs(trueitem - truefac)) < 0.00001) {
				avevar[j] <- sum(trueitem) / sum(trueitem + erritem)
			} else {
				avevar[j] <- NA
			}
			if (categorical) {
				omega1[j] <- omegaCat(truevar = faccontrib[index, index, drop = FALSE],
				                      implied = SigmaHat[[i]][index, index, drop = FALSE],
				                      threshold = threshold[[i]][index],
				                      denom = faccontrib[index, index, drop = FALSE] + te[[i]][index, index, drop = FALSE])
				omega2[j] <- omegaCat(truevar = faccontrib[index, index, drop = FALSE],
				                      implied = SigmaHat[[i]][index, index, drop = FALSE],
				                      threshold = threshold[[i]][index],
				                      denom = SigmaHat[[i]][index, index, drop = FALSE])
				omega3[j] <- omegaCat(truevar = faccontrib[index, index, drop = FALSE],
				                      implied = SigmaHat[[i]][index, index, drop = FALSE],
				                      threshold = threshold[[i]][index],
				                      denom = sigma)
			} else {
				omega1[j] <- commonfac / (commonfac + error[j])
				omega2[j] <- commonfac / impliedTotal[j]
				omega3[j] <- commonfac / total[j]
			}
		}
		alpha <- c(alpha, total = computeAlpha(S[[i]], nrow(S[[i]])))
		names(alpha) <- c(names(common), "total")
		if (categorical) {
			omega1 <- c(omega1, total = omegaCat(truevar = truevar,
			                                     implied = SigmaHat[[i]],
			                                     threshold = threshold[[i]],
			                                     denom = truevar + te[[i]]))
			omega2 <- c(omega2, total = omegaCat(truevar = truevar,
			                                     implied = SigmaHat[[i]],
			                                     threshold = threshold[[i]],
			                                     denom = SigmaHat[[i]]))
			omega3 <- c(omega3, total = omegaCat(truevar = truevar,
			                                     implied = SigmaHat[[i]],
			                                     threshold = threshold[[i]],
			                                     denom = S[[i]]))
		} else {
			omega1 <- c(omega1, total = sum(truevar) / (sum(truevar) + sum(te[[i]])))
			omega2 <- c(omega2, total = sum(truevar) / (sum(SigmaHat[[i]])))
			omega3 <- c(omega3, total = sum(truevar) / (sum(S[[i]])))
		}
		avevar <- c(avevar, total = sum(diag(truevar))/ sum((diag(truevar) + diag(te[[i]]))))
		singleIndicator <- apply(ly[[i]], 2, function(x) sum(x != 0)) %in% 0:1
		result[[i]] <- rbind(alpha = alpha, omega = omega1, omega2 = omega2,
		                     omega3 = omega3, avevar = avevar)[ , !singleIndicator]
	}
	if (flag) warning("The alpha and the average variance extracted are",
	                  " calculated from polychoric (polyserial) correlation not",
	                  " from Pearson's correlation.\n")
	if (ngroup == 1L) {
		result <- result[[1]]
	} else {
		names(result) <- lavInspect(object, "group.label")
	}
	result
}



#' Calculate the reliability values of a second-order factor
#'
#' Calculate the reliability values (coefficient omega) of a second-order
#' factor
#'
#' The first formula of the coefficient omega (in the
#' \code{\link{reliability}}) will be mainly used in the calculation. The
#' model-implied covariance matrix of a second-order factor model can be
#' separated into three sources: the second-order factor, the uniqueness of the
#' first-order factor, and the measurement error of indicators:
#'
#' \deqn{ \hat{\Sigma} = \Lambda \bold{B} \Phi_2 \bold{B}^{\prime}
#' \Lambda^{\prime} + \Lambda \Psi_{u} \Lambda^{\prime} + \Theta, }
#'
#' where \eqn{\hat{\Sigma}} is the model-implied covariance matrix,
#' \eqn{\Lambda} is the first-order factor loading, \eqn{\bold{B}} is the
#' second-order factor loading, \eqn{\Phi_2} is the covariance matrix of the
#' second-order factors, \eqn{\Psi_{u}} is the covariance matrix of the unique
#' scores from first-order factors, and \eqn{\Theta} is the covariance matrix
#' of the measurement errors from indicators. Thus, the proportion of the
#' second-order factor explaining the total score, or the coefficient omega at
#' Level 1, can be calculated:
#'
#' \deqn{ \omega_{L1} = \frac{\bold{1}^{\prime} \Lambda \bold{B} \Phi_2
#' \bold{B}^{\prime} \Lambda^{\prime} \bold{1}}{\bold{1}^{\prime} \Lambda
#' \bold{B} \Phi_2 \bold{B} ^{\prime} \Lambda^{\prime} \bold{1} +
#' \bold{1}^{\prime} \Lambda \Psi_{u} \Lambda^{\prime} \bold{1} +
#' \bold{1}^{\prime} \Theta \bold{1}}, }
#'
#' where \eqn{\bold{1}} is the \emph{k}-dimensional vector of 1 and \emph{k} is
#' the number of observed variables. When model-implied covariance matrix among
#' first-order factors (\eqn{\Phi_1}) can be calculated:
#'
#' \deqn{ \Phi_1 = \bold{B} \Phi_2 \bold{B}^{\prime} + \Psi_{u}, }
#'
#' Thus, the proportion of the second-order factor explaining the varaince at
#' first-order factor level, or the coefficient omega at Level 2, can be
#' calculated:
#'
#' \deqn{ \omega_{L2} = \frac{\bold{1_F}^{\prime} \bold{B} \Phi_2
#' \bold{B}^{\prime} \bold{1_F}}{\bold{1_F}^{\prime} \bold{B} \Phi_2
#' \bold{B}^{\prime} \bold{1_F} + \bold{1_F}^{\prime} \Psi_{u} \bold{1_F}}, }
#'
#' where \eqn{\bold{1_F}} is the \emph{F}-dimensional vector of 1 and \emph{F}
#' is the number of first-order factors.
#'
#' The partial coefficient omega at Level 1, or the proportion of observed
#' variance explained by the second-order factor after partialling the
#' uniqueness from the first-order factor, can be calculated:
#'
#' \deqn{ \omega_{L1} = \frac{\bold{1}^{\prime} \Lambda \bold{B} \Phi_2
#' \bold{B}^{\prime} \Lambda^{\prime} \bold{1}}{\bold{1}^{\prime} \Lambda
#' \bold{B} \Phi_2 \bold{B}^{\prime} \Lambda^{\prime} \bold{1} +
#' \bold{1}^{\prime} \Theta \bold{1}}, }
#'
#' Note that if the second-order factor has a direct factor loading on some
#' observed variables, the observed variables will be counted as first-order
#' factors.
#'
#'
#' @importFrom lavaan lavInspect
#'
#' @param object The lavaan model object provided after running the \code{cfa},
#' \code{sem}, \code{growth}, or \code{lavaan} functions that has a
#' second-order factor
#' @param secondFactor The name of the second-order factor
#' @return Reliability values at Levels 1 and 2 of the second-order factor, as
#' well as the partial reliability value at Level 1
#' @author Sunthud Pornprasertmanit (\email{psunthud@@gmail.com})
#' @seealso \code{\link{reliability}} for the reliability of the first-order
#' factors.
#' @examples
#'
#' library(lavaan)
#'
#' HS.model3 <- ' visual  =~ x1 + x2 + x3
#'                textual =~ x4 + x5 + x6
#'                speed   =~ x7 + x8 + x9
#' 			          higher =~ visual + textual + speed'
#'
#' fit6 <- cfa(HS.model3, data = HolzingerSwineford1939)
#' reliability(fit6) # Should provide a warning for the endogenous variables
#' reliabilityL2(fit6, "higher")
#'
#' @export
reliabilityL2 <- function(object, secondFactor) {
	param <- lavInspect(object, "est")
	ngroup <- lavInspect(object, "ngroups")
	name <- names(param)
	if (ngroup == 1L) {
		ly <- param[name == "lambda"]
	} else {
		ly <- lapply(param, "[[", "lambda")
	}
	ve <- lavInspect(object, "cov.lv")
	if (ngroup == 1L) ve <- list(ve)
	if (ngroup == 1L) {
		ps <- param[name == "psi"]
		te <- param[name == "theta"]
		be <- param[name == "beta"]
	} else {
		ps <- lapply(param, "[[", "psi")
		te <- lapply(param, "[[", "theta")
		be <- lapply(param, "[[", "beta")
	}
	SigmaHat <- lavInspect(object, "cov.ov")
	if (ngroup == 1L) {
		SigmaHat <- list(SigmaHat)
		S <- list(lavInspect(object, "sampstat")$cov)
	} else {
		S <- lapply(lavInspect(object, "sampstat"), function(x) x$cov)
	}
	result <- list()
	for (i in 1:ngroup) {

		# Prepare for higher-order reliability
		l2var <- ve[[i]][secondFactor, secondFactor, drop = FALSE]
		l2load <- be[[1]][,secondFactor]
		indexl2 <- which(l2load != 0)
		commonl2 <- (sum(l2load)^2) * l2var
		errorl2 <- sum(ps[[i]][indexl2, indexl2, drop = FALSE])

		# Prepare for lower-order reliability
		indexl1 <- which(apply(ly[[i]][,indexl2], 1, function(x) sum(x != 0)) > 0)
		l1load <- ly[[i]][,indexl2] %*% as.matrix(be[[1]][indexl2, secondFactor, drop = FALSE])
		commonl1 <- (sum(l1load)^2) * l2var
		errorl1 <- sum(te[[i]][indexl1, indexl1, drop = FALSE])
		uniquel1 <- 0
		for (j in seq_along(indexl2)) {
			uniquel1 <- uniquel1 + (sum(ly[[i]][,indexl2[j]])^2) * ps[[i]][indexl2[j], indexl2[j], drop = FALSE]
		}

		# Adjustment for direct loading from L2 to observed variables
		if (any(ly[[i]][,secondFactor] != 0)) {
			indexind <- which(ly[[i]][,secondFactor] != 0)
			if (length(intersect(indexind, indexl1)) > 0)
			  stop("Direct and indirect loadings of higher-order factor to observed",
			       " variables are specified at the same time.")
			commonl2 <- sum(c(ly[[i]][,secondFactor], l2load))^2 * l2var
			errorl2 <- errorl2 + sum(te[[i]][indexind, indexind, drop = FALSE])
			commonl1 <- sum(c(ly[[i]][,secondFactor], l1load))^2 * l2var
			errorl1 <- errorl1 + sum(te[[i]][indexind, indexind, drop = FALSE])
		}

		# Calculate Reliability
		omegaL1 <- commonl1 / (commonl1 + uniquel1 + errorl1)
		omegaL2 <- commonl2 / (commonl2 + errorl2)
		partialOmegaL1 <- commonl1 / (commonl1 + errorl1)
		result[[i]] <- c(omegaL1 = omegaL1, omegaL2 = omegaL2, partialOmegaL1 = partialOmegaL1)
	}
	if (ngroup == 1L) {
		result <- result[[1]]
	} else {
		names(result) <- lavInspect(object, "group.label")
	}
	result
}



#' Calculate maximal reliability
#'
#' Calculate maximal reliability of a scale
#'
#' Given that a composite score (\eqn{W}) is a weighted sum of item scores:
#'
#' \deqn{ W = \bold{w}^\prime \bold{x} ,}
#'
#' where \eqn{\bold{x}} is a \eqn{k \times 1} vector of the scores of each
#' item, \eqn{\bold{w}} is a \eqn{k \times 1} weight vector of each item, and
#' \eqn{k} represents the number of items. Then, maximal reliability is
#' obtained by finding \eqn{\bold{w}} such that reliability attains its maximum
#' (Li, 1997; Raykov, 2012). Note that the reliability can be obtained by
#'
#' \deqn{ \rho = \frac{\bold{w}^\prime \bold{S}_T \bold{w}}{\bold{w}^\prime
#' \bold{S}_X \bold{w}}}
#'
#' where \eqn{\bold{S}_T} is the covariance matrix explained by true scores and
#' \eqn{\bold{S}_X} is the observed covariance matrix. Numerical method is used
#' to find \eqn{\bold{w}} in this function.
#'
#' For continuous items, \eqn{\bold{S}_T} can be calculated by
#'
#' \deqn{ \bold{S}_T = \Lambda \Psi \Lambda^\prime,}
#'
#' where \eqn{\Lambda} is the factor loading matrix and \eqn{\Psi} is the
#' covariance matrix among factors. \eqn{\bold{S}_X} is directly obtained by
#' covariance among items.
#'
#' For categorical items, Green and Yang's (2009) method is used for
#' calculating \eqn{\bold{S}_T} and \eqn{\bold{S}_X}. The element \eqn{i} and
#' \eqn{j} of \eqn{\bold{S}_T} can be calculated by
#'
#' \deqn{ \left[\bold{S}_T\right]_{ij} = \sum^{C_i - 1}_{c_i = 1} \sum^{C_j -
#' 1}_{c_j - 1} \Phi_2\left( \tau_{x_{c_i}}, \tau_{x_{c_j}}, \left[ \Lambda
#' \Psi \Lambda^\prime \right]_{ij} \right) - \sum^{C_i - 1}_{c_i = 1}
#' \Phi_1(\tau_{x_{c_i}}) \sum^{C_j - 1}_{c_j - 1} \Phi_1(\tau_{x_{c_j}}),}
#'
#' where \eqn{C_i} and \eqn{C_j} represents the number of thresholds in Items
#' \eqn{i} and \eqn{j}, \eqn{\tau_{x_{c_i}}} represents the threshold \eqn{c_i}
#' of Item \eqn{i}, \eqn{\tau_{x_{c_j}}} represents the threshold \eqn{c_i} of
#' Item \eqn{j}, \eqn{ \Phi_1(\tau_{x_{c_i}})} is the cumulative probability of
#' \eqn{\tau_{x_{c_i}}} given a univariate standard normal cumulative
#' distribution and \eqn{\Phi_2\left( \tau_{x_{c_i}}, \tau_{x_{c_j}}, \rho
#' \right)} is the joint cumulative probability of \eqn{\tau_{x_{c_i}}} and
#' \eqn{\tau_{x_{c_j}}} given a bivariate standard normal cumulative
#' distribution with a correlation of \eqn{\rho}
#'
#' Each element of \eqn{\bold{S}_X} can be calculated by
#'
#' \deqn{ \left[\bold{S}_T\right]_{ij} = \sum^{C_i - 1}_{c_i = 1} \sum^{C_j -
#' 1}_{c_j - 1} \Phi_2\left( \tau_{V_{c_i}}, \tau_{V_{c_j}}, \rho^*_{ij}
#' \right) - \sum^{C_i - 1}_{c_i = 1} \Phi_1(\tau_{V_{c_i}}) \sum^{C_j -
#' 1}_{c_j - 1} \Phi_1(\tau_{V_{c_j}}),}
#'
#' where \eqn{\rho^*_{ij}} is a polychoric correlation between Items \eqn{i}
#' and \eqn{j}.
#'
#'
#' @importFrom lavaan lavInspect
#'
#' @param object The lavaan model object provided after running the \code{cfa},
#' \code{sem}, \code{growth}, or \code{lavaan} functions.
#' @return Maximal reliability values of each group. The maximal-reliability
#' weights are also provided. Users may extracted the weighted by the
#' \code{attr} function (see example below).
#' @author Sunthud Pornprasertmanit (\email{psunthud@@gmail.com})
#' @seealso \code{\link{reliability}} for reliability of an unweighted
#' composite score
#' @references
#' Li, H. (1997). A unifying expression for the maximal reliability of a linear
#' composite. \emph{Psychometrika, 62}(2), 245--249. doi:10.1007/BF02295278
#'
#' Raykov, T. (2012). Scale construction and development using structural
#' equation modeling. In R. H. Hoyle (Ed.), \emph{Handbook of structural
#' equation modeling} (pp. 472--494). New York, NY: Guilford.
#' @examples
#'
#' total <- 'f =~ x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9 '
#' fit <- cfa(total, data = HolzingerSwineford1939)
#' maximalRelia(fit)
#'
#' # Extract the weight
#' mr <- maximalRelia(fit)
#' attr(mr, "weight")
#'
#' @export
maximalRelia <- function(object) {
  param <- lavInspect(object, "est")
  ngroup <- lavInspect(object, "ngroups")
  categorical <- length(lavNames(object, "ov.ord"))
  name <- names(param)
  if (ngroup == 1L) {
    ly <- param[name == "lambda"]
  } else {
    ly <- lapply(param, "[[", "lambda")
  }
  ps <- lavInspect(object, "cov.lv")
  SigmaHat <- lavInspect(object, "cov.ov")
  if (ngroup == 1L) {
    ps <- list(ps)
    SigmaHat <- list(SigmaHat)
    S <- list(lavInspect(object, "sampstat")$cov)
  } else {
    S <- lapply(lavInspect(object, "sampstat"), function(x) x$cov)
  }
  threshold <- NULL
  result <- list()
  if (categorical) threshold <- getThreshold(object) # change to lavInspect(object, "th")?
  ## No, it is a list per item, rather than a single vector
  for (i in 1:ngroup) {
    truevar <- ly[[i]] %*% ps[[i]] %*% t(ly[[i]])
    varnames <- colnames(truevar)
    if (categorical) {
      invstdvar <- 1 / sqrt(diag(SigmaHat[[i]]))
      polyr <- diag(invstdvar) %*% truevar %*% diag(invstdvar)
      nitem <- ncol(SigmaHat[[i]])
      result[[i]] <- calcMaximalReliaCat(polyr, threshold[[i]], S[[i]], nitem, varnames)
    } else {
      result[[i]] <- calcMaximalRelia(truevar, S[[i]], varnames)
    }
  }
  if (ngroup == 1L) {
    result <- result[[1]]
  } else {
    names(result) <- lavInspect(object, "group.label")
  }
  result
}



## ----------------
## Hidden Functions
## ----------------

computeAlpha <- function(S, k) k/(k - 1) * (1.0 - sum(diag(S)) / sum(S))

#' @importFrom stats cov2cor pnorm
omegaCat <- function(truevar, implied, threshold, denom) {
	# denom could be polychoric correlation, model-implied correlation, or model-implied without error correlation
	polyc <- truevar
	invstdvar <- 1 / sqrt(diag(implied))
	polyr <- diag(invstdvar) %*% polyc %*% diag(invstdvar)
	nitem <- ncol(implied)
	denom <- cov2cor(denom)
	sumnum <- 0
	addden <- 0
	for (j in 1:nitem) {
  	for (jp in 1:nitem) {
  		sumprobn2 <- 0
  		addprobn2 <- 0
  		t1 <- threshold[[j]]
  		t2 <- threshold[[jp]]
  		for (c in 1:length(t1)) {
    		for (cp in 1:length(t2)) {
    			sumprobn2 <- sumprobn2 + p2(t1[c], t2[cp], polyr[j, jp])
    			addprobn2 <- addprobn2 + p2(t1[c], t2[cp], denom[j, jp])
    		}
  		}
  		sumprobn1 <- sum(pnorm(t1))
  		sumprobn1p <- sum(pnorm(t2))
  		sumnum <- sumnum + (sumprobn2 - sumprobn1 * sumprobn1p)
  		addden <- addden + (addprobn2 - sumprobn1 * sumprobn1p)
  	}
	}
	reliab <- sumnum / addden
	reliab
}


p2 <- function(t1, t2, r) {
	mnormt::pmnorm(c(t1, t2), c(0,0), matrix(c(1, r, r, 1), 2, 2))
}


# polycorLavaan <- function(object) {
# 	ngroups <- lavInspect(object, "ngroups")
# 	coef <- lavInspect(object, "est")
# 	targettaunames <- NULL
# 	if (ngroups == 1L) {
# 		targettaunames <- rownames(coef$tau)
# 	} else {
# 		targettaunames <- rownames(coef[[1]]$tau)
# 	}
# 	barpos <- sapply(strsplit(targettaunames, ""), function(x) which(x == "|"))
# 	varnames <- unique(apply(data.frame(targettaunames, barpos - 1), MARGIN = 1,
# 	                         FUN = function(x) substr(x[1], 1, x[2])))
# 	if (length(varnames))
# 	script <- ""
# 	for (i in 2:length(varnames)) {
# 		temp <- paste0(varnames[1:(i - 1)], collapse = " + ")
# 		temp <- paste0(varnames[i], "~~", temp, "\n")
# 		script <- paste(script, temp)
# 	}
# 	newobject <- refit(script, object)
# 	if (ngroups == 1L) {
# 		return(lavInspect(newobject, "est")$theta)
# 	}
# 	lapply(lavInspect(newobject, "est"), "[[", "theta")
# }

#' @importFrom lavaan lavInspect
getThreshold <- function(object) {
	ngroups <- lavInspect(object, "ngroups")
	coef <- lavInspect(object, "est")
	result <- NULL
	if (ngroups == 1L) {
		targettaunames <- rownames(coef$tau)
		barpos <- sapply(strsplit(targettaunames, ""), function(x) which(x == "|"))
		varthres <- apply(data.frame(targettaunames, barpos - 1), 1, function(x) substr(x[1], 1, x[2]))
		result <- list(split(coef$tau, varthres))
	} else {
		result <- list()
		for (g in 1:ngroups) {
			targettaunames <- rownames(coef[[g]]$tau)
			barpos <- sapply(strsplit(targettaunames, ""), function(x) which(x == "|"))
			varthres <- apply(data.frame(targettaunames, barpos - 1), 1, function(x) substr(x[1], 1, x[2]))
			result[[g]] <- split(coef[[g]]$tau, varthres)
		}
	}
	return(result)
}

invGeneralRelia <- function(w, truevar, totalvar) {
	1 - (t(w) %*% truevar %*% w) / (t(w) %*% totalvar %*% w)
}

#' @importFrom stats pnorm
invGeneralReliaCat <- function(w, polyr, threshold, denom, nitem) {
	# denom could be polychoric correlation, model-implied correlation, or model-implied without error correlation
	upper <- matrix(NA, nitem, nitem)
	lower <- matrix(NA, nitem, nitem)
	for (j in 1:nitem) {
  	for (jp in 1:nitem) {
  		sumprobn2 <- 0
  		addprobn2 <- 0
  		t1 <- threshold[[j]]
  		t2 <- threshold[[jp]]
  		for (c in 1:length(t1)) {
  		for (cp in 1:length(t2)) {
  			sumprobn2 <- sumprobn2 + p2(t1[c], t2[cp], polyr[j, jp])
  			addprobn2 <- addprobn2 + p2(t1[c], t2[cp], denom[j, jp])
  		}
  		}
  		sumprobn1 <- sum(pnorm(t1))
  		sumprobn1p <- sum(pnorm(t2))
  		upper[j, jp] <- (sumprobn2 - sumprobn1 * sumprobn1p)
  		lower[j, jp] <- (addprobn2 - sumprobn1 * sumprobn1p)
  	}
	}
	1 - (t(w) %*% upper %*% w) / (t(w) %*% lower %*% w)
}

#' @importFrom stats nlminb
calcMaximalRelia <- function(truevar, totalvar, varnames) {
	start <- rep(1, nrow(truevar))
	out <- nlminb(start, invGeneralRelia, truevar = truevar, totalvar = totalvar)
	if (out$convergence != 0) stop("The numerical method for finding the maximal",
	                               " reliability was not converged.")
	result <- 1 - out$objective
	weight <- out$par / mean(out$par)
	names(weight) <- varnames
	attr(result, "weight") <- weight
	result
}

#' @importFrom stats nlminb
calcMaximalReliaCat <- function(polyr, threshold, denom, nitem, varnames) {
	start <- rep(1, nrow(polyr))
	out <- nlminb(start, invGeneralReliaCat, polyr = polyr, threshold = threshold, denom = denom, nitem = nitem)
	if (out$convergence != 0) stop("The numerical method for finding the maximal",
	                               " reliability was not converged.")
	result <- 1 - out$objective
	weight <- out$par / mean(out$par)
	names(weight) <- varnames
	attr(result, "weight") <- weight
	result
}


