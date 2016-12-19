#####
# FAVOR PREENCHER ESSES DADOS!!
#####
#data > escreva_a_data_de_hoje_com_6_números_010117
dia <- format(Sys.time(), "%d_%m_%Y")
# pesquisador > Iniciais do pesquisador solicitante
pesq <- "WS"
#coorte
cohort <- "MS"
#path > local onde está o aruivo
path <- "~/Documents/Walter/Imputed_Genes/"
setwd(path)
# arquivo em vcf gerado pelo plink > ~/path/_to_/plink_vcf.vcf
plink_vcf <- "Walter2.vcf"

#######
#FAVOR NÃO MUDAR NADA DAQUI PARA BAIXO
######
# Converter arquivos .vcf para SPSS
#chamar o vcf
vcf <-read.table(plink_vcf, comment.char = "", skip = 18, header = T, check.names = F, stringsAsFactors= F)
ncols <- length(names(vcf))
cols <- c(10:ncols)
SPSS <- as.data.frame(t(vcf[,cols]), stringsAsFactors = F)
SNPs <- as.data.frame(vcf[,c(1:9)], stringsAsFactors=FALSE)
names(SPSS) <- SNPs$ID
rownames(SPSS) <- gsub("0_", "", rownames(SPSS))
SPSS[ SPSS == "0/0" ] <- 0
SPSS[ SPSS == "0/1" ] <- 1
SPSS[ SPSS == "1/1" ] <- 2
SPSS[ SPSS == "./." ] <- NA
SPSS$ID <- rownames(SPSS)

# se for para colaborador internacional mudar para csv ou txt
write.csv2(SPSS, file = paste(cohort,pesq,dia,"SPSS.csv", sep = "_"), row.names=F)
write.table(SNPs,file = paste(cohort,pesq,dia,"SNPsINFO.txt",sep = "_"), quote = F, row.names = F)
  