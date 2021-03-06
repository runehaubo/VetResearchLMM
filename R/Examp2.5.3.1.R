#' @title    Examp2.5.3.1 from Duchateau, L. and Janssen, P. and Rowlands, G. J. (1998).\emph{Linear Mixed Models. An Introduction with applications in Veterinary Research}. International Livestock Research Institute.
#' @name     Examp2.5.3.1
#' @docType  data
#' @keywords datasets
#' @description Examp2.5.3.1 is used for inspecting probability distribution and to define a plausible process through
#' linear models and generalized linear models.
#' @author \enumerate{
#'          \item  Muhammad Yaseen (\email{myaseen208@@gmail.com})
#'          }
#' @references \enumerate{
#' \item Duchateau, L. and Janssen, P. and Rowlands, G. J. (1998).\emph{Linear Mixed Models. An Introduction with applications in Veterinary Research}.
#'              International Livestock Research Institute.
#'  }
#' @seealso
#'    \code{\link{ex124}}
#' @importFrom ggplot2 ggplot
#' @importFrom lme4 lmer
#' @importFrom multcomp glht
#' @examples
#' #-------------------------------------------------------------
#' ## Example 2.5.3.1 p-70
#' #-------------------------------------------------------------
#'  # PROC GLM DATA=ex125;
#'  # CLASS drug dose region;
#'  # MODEL pcv=region drug region*drug dose drug*dose;
#'  # RANDOM region drug*region;
#'  # RUN;
#'
#'
#'  # PROC MIXED DATA=ex125;
#'  # CLASS drug dose region;
#'  # MODEL pcv=drug dose drug*dose / ddfm=satterth;
#'  # RANDOM region drug*region;
#'  # ESTIMATE 'drug dif' drug -1 1 drug*dose -0.5 -0.5 0.5 0.5;
#'  # ESTIMATE 'Samorin mean' INTERCEPT 1 drug 0 1 dose 0.5 0.5
#'  #                             drug*dose 0 0 0.5 0.5;
#'  # ESTIMATE 'Samorin HvsL' dose 1 -1 drug*dose 0 0 1 -1;
#'  # ESTIMATE 'Samorin high' INTERCEPT 1 drug 0 1 dose 1 0
#'  #                             drug*dose 0 0 1 0;
#'  # RUN;
#'
#' library(lme4)
#' str(ex125)
#' ex125$Region1 <- factor(ex125$Region)
#'  fm2.11 <-
#'   aov(
#'       formula     = Pcv ~ Region1 + Drug + Error(Drug:Region1) + dose + dose:Drug
#'     , data        = ex125
#'     , projections = FALSE
#'     , qr          = TRUE
#'     , contrasts   = NULL
#'   #  , ...
#'     )
#'  summary(fm2.11)
#'
#'  fm2.12 <-
#'   lmerTest::lmer(
#'          formula    = Pcv ~ dose*Drug + (1|Region/Drug)
#'        , data       = ex125
#'        , REML       = TRUE
#'        , control    = lmerControl()
#'        , start      = NULL
#'        , verbose    = 0L
#'     #  , subset
#'     #  , weights
#'     #  , na.action
#'     #  , offset
#'        , contrasts  = list(dose = "contr.SAS", Drug = "contr.SAS")
#'        , devFunOnly = FALSE
#'     #  , ...
#'        )
#'  summary(fm2.12)
#'  anova(object = fm2.12, ddf = "Satterthwaite")
#'
#' library(multcomp)
#' Contrasts1 <-
#'           matrix(c(
#'                   1, 0.5, 0, 0
#'                 , 0, 0, -1, -0.5
#'                 , 1, 1, 0, 0
#'                 , 0, 1, 0, 0
#'                 )
#'                , ncol = 4
#'                , byrow = TRUE
#'                , dimnames = list(
#'                   c("C1", "C2", "C3", "C4")
#'                 , rownames(summary(fm2.12)$coef)
#'                )
#'               )
#'
#' Contrasts1
#' summary(glht(fm2.12, linfct=Contrasts1))
#'
NULL
