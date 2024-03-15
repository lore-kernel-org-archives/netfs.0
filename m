Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203A35336A
	for <netfs@lists.linux.dev>; Fri, 15 Mar 2024 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535888; cv=none; b=sGg1211PpbSYeB/3iGlmXEhx6hlmadL+i5a2PF8e0vl3bAttg7VnYQKi1CetwqzfaEWmtR/zMviVY5XM1tyPMyQ71jsYQdNXpbKi7SO1vhPRTU1D2Kd3iv5/BoXgKLpx3+Q1XALBLGxOinnN9pjaS4aZLCTWGlzIonwOVmaNWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535888; c=relaxed/simple;
	bh=ltXoId498AiO/30grKuZlMlq+tUWSOpSAWm/2NMtmLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/KX8AAVeJ41TaOFZjj0zRNU4em0kMxTrhHxsvmZxagA43vAvdgiiWaySrdGS0ASdy+TfqHVlJIKsevwEwdZ77r/x6QECoFsbZKPt1VbsDiuJAWDAu9sjhoYoRNgGaTqkXyWWawqmLjYkVSZECrSZIVuFRDIynckhoRli8PmprA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9se5c5q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9se5c5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE2EC433F1
	for <netfs@lists.linux.dev>; Fri, 15 Mar 2024 20:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535887;
	bh=ltXoId498AiO/30grKuZlMlq+tUWSOpSAWm/2NMtmLg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N9se5c5qN+qPPTm4rA+04AoO8NPEjDYK/p+htZIvJ58PhH+/ADx8cfgBhMNiNcvYn
	 IE8507TEklF+NRdPbSmAQQ6USWTJxyCUbF8qbrQUKjRoA/+sWXkL/Eh9YVTeKe5Ent
	 jwjgiHhc31uWe4roVDHX7rPd80F9V5tBHl+AIE+AH6AiQxu9Yb581sfnQTKS1hPc+d
	 pQ3HcyaSiSFi+9fkmUo/KEI36SFaefrBAsLPK9dn1iXVVR4yzRbDBunIiek6UhoHDl
	 Gx59CFoxO9hfSdMBODOHosrGvO+vaNOulZvnbNzfKLI4Jw3sDb0LRo2cF8Vtjpy66H
	 /KfEuyE61+UdA==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-609ed7ca444so25846657b3.1
        for <netfs@lists.linux.dev>; Fri, 15 Mar 2024 13:51:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvc7S6CqYU+5VKsCcb0EW9R0/ZymjVQnuM5vZ9nWoG6CxPOvCBR0psCsCyeRE+tZrV8PQsJUd36B/Be0KEOSKCh5j/78Q=
X-Gm-Message-State: AOJu0YyLOuAau5fB25ktvYruRP8iRYmXnVKenWJO0Pt5XGQjp23WpoKP
	RfcSGh6vlb8iOR8L+YvFo2x4RbqIiWN1MD5mQYb70ofFYAGlRQ1Cj7hdGdgys5eVTH1ckhSUFu/
	qUtQtR5tXxMbYlbgLQItjlMplYgM=
X-Google-Smtp-Source: AGHT+IGET8xwI3RnqbMCBle+J+vig4o2hHdhxNsQ/Tg1+24ag8QltmBO+43+Nn6/Nn43j6qBbbvvZhy8NrbcaHjAt2g=
X-Received: by 2002:ac8:7dc1:0:b0:42e:fa57:e07e with SMTP id
 c1-20020ac87dc1000000b0042efa57e07emr5976112qte.9.1710535866260; Fri, 15 Mar
 2024 13:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org> <20240315-dir-deleg-v1-21-a1d6209a3654@kernel.org>
In-Reply-To: <20240315-dir-deleg-v1-21-a1d6209a3654@kernel.org>
From: Anna Schumaker <anna@kernel.org>
Date: Fri, 15 Mar 2024 16:50:50 -0400
X-Gmail-Original-Message-ID: <CAFX2Jfk_np=agEWY0aPkosssBkfx9S+ur-L1=91psn-hdgK+RA@mail.gmail.com>
Message-ID: <CAFX2Jfk_np=agEWY0aPkosssBkfx9S+ur-L1=91psn-hdgK+RA@mail.gmail.com>
Subject: Re: [PATCH RFC 21/24] nfs: add a GDD_GETATTR rpc operation
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Fri, Mar 15, 2024 at 12:54=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> Add a new compound that does a GET_DIR_DELEGATION just before doing a
> GETATTR on an inode. Add a delegation stateid and a nf_status code to
> struct nfs4_getattr_res to store the result.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfs/nfs4xdr.c        | 136 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/nfs4.h    |   1 +
>  include/linux/nfs_xdr.h |   2 +
>  3 files changed, 139 insertions(+)
>
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index 1416099dfcd1..c28025018bda 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -391,6 +391,22 @@ static int decode_layoutget(struct xdr_stream *xdr, =
struct rpc_rqst *req,
>                                 XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN) + 5)
>  #define encode_reclaim_complete_maxsz  (op_encode_hdr_maxsz + 4)
>  #define decode_reclaim_complete_maxsz  (op_decode_hdr_maxsz + 4)
> +#define encode_get_dir_delegation_maxsz (op_encode_hdr_maxsz +          =
               \
> +                                        4 /* gdda_signal_deleg_avail */ =
+              \
> +                                        8 /* gdda_notification_types */ =
+              \
> +                                        nfstime4_maxsz  /* gdda_child_at=
tr_delay */ +  \
> +                                        nfstime4_maxsz  /* gdda_dir_attr=
_delay */ +    \
> +                                        nfs4_fattr_bitmap_maxsz /* gdda_=
child_attributes */ + \
> +                                        nfs4_fattr_bitmap_maxsz /* gdda_=
dir_attributes */)
> +
> +#define decode_get_dir_delegation_maxsz (op_encode_hdr_maxsz +          =
               \
> +                                        4 /* gddrnf_status */ +         =
               \
> +                                        encode_verifier_maxsz /* gddr_co=
okieverf */ +  \
> +                                        encode_stateid_maxsz /* gddr_sta=
teid */ +      \
> +                                        8 /* gddr_notification */ +     =
               \
> +                                        nfs4_fattr_bitmap_maxsz /* gddr_=
child_attributes */ + \
> +                                        nfs4_fattr_bitmap_maxsz /* gddr_=
dir_attributes */)
> +
>  #define encode_getdeviceinfo_maxsz (op_encode_hdr_maxsz + \
>                                 XDR_QUADLEN(NFS4_DEVICEID4_SIZE) + \
>                                 1 /* layout type */ + \
> @@ -636,6 +652,18 @@ static int decode_layoutget(struct xdr_stream *xdr, =
struct rpc_rqst *req,
>                                 decode_putfh_maxsz + \
>                                 decode_getattr_maxsz + \
>                                 decode_renew_maxsz)
> +#define NFS4_enc_gdd_getattr_sz        (compound_encode_hdr_maxsz + \
> +                               encode_sequence_maxsz + \
> +                               encode_putfh_maxsz + \
> +                               encode_get_dir_delegation_maxsz + \
> +                               encode_getattr_maxsz + \
> +                               encode_renew_maxsz)
> +#define NFS4_dec_gdd_getattr_sz        (compound_decode_hdr_maxsz + \
> +                               decode_sequence_maxsz + \
> +                               decode_putfh_maxsz + \
> +                               decode_get_dir_delegation_maxsz + \
> +                               decode_getattr_maxsz + \
> +                               decode_renew_maxsz)
>  #define NFS4_enc_lookup_sz     (compound_encode_hdr_maxsz + \
>                                 encode_sequence_maxsz + \
>                                 encode_putfh_maxsz + \
> @@ -1981,6 +2009,30 @@ static void encode_sequence(struct xdr_stream *xdr=
,
>  }
>
>  #ifdef CONFIG_NFS_V4_1
> +static void
> +encode_get_dir_delegation(struct xdr_stream *xdr, struct compound_hdr *h=
dr)
> +{
> +       __be32 *p;
> +       struct timespec64 ts =3D {};
> +       u32 zerobm[1] =3D {};
> +
> +       encode_op_hdr(xdr, OP_GET_DIR_DELEGATION, decode_get_dir_delegati=
on_maxsz, hdr);
> +
> +       /* We can't handle CB_RECALLABLE_OBJ_AVAIL yet */
> +       xdr_stream_encode_bool(xdr, false);
> +
> +       /* for now, we request no notification types */
> +       xdr_encode_bitmap4(xdr, zerobm, ARRAY_SIZE(zerobm));
> +
> +       /* Request no attribute updates */
> +       p =3D reserve_space(xdr, 12 + 12);
> +       p =3D xdr_encode_nfstime4(p, &ts);
> +       xdr_encode_nfstime4(p, &ts);
> +
> +       xdr_encode_bitmap4(xdr, zerobm, ARRAY_SIZE(zerobm));
> +       xdr_encode_bitmap4(xdr, zerobm, ARRAY_SIZE(zerobm));
> +}
> +
>  static void
>  encode_getdeviceinfo(struct xdr_stream *xdr,
>                      const struct nfs4_getdeviceinfo_args *args,
> @@ -2334,6 +2386,25 @@ static void nfs4_xdr_enc_getattr(struct rpc_rqst *=
req, struct xdr_stream *xdr,
>         encode_nops(&hdr);
>  }
>
> +/*
> + * Encode GDD_GETATTR request
> + */
> +static void nfs4_xdr_enc_gdd_getattr(struct rpc_rqst *req, struct xdr_st=
ream *xdr,
> +                                    const void *data)
> +{
> +       const struct nfs4_getattr_arg *args =3D data;
> +       struct compound_hdr hdr =3D {
> +               .minorversion =3D nfs4_xdr_minorversion(&args->seq_args),
> +       };
> +
> +       encode_compound_hdr(xdr, req, &hdr);
> +       encode_sequence(xdr, &args->seq_args, &hdr);
> +       encode_putfh(xdr, args->fh, &hdr);
> +       encode_get_dir_delegation(xdr, &hdr);
> +       encode_getfattr(xdr, args->bitmask, &hdr);
> +       encode_nops(&hdr);
> +}
> +

This function should be under a "#ifdef CONFIG_NFS_V4_1" to avoid the
following compiler error:

fs/nfs/nfs4xdr.c:2403:2: error: call to undeclared function
'encode_get_dir_delegation'; ISO C99 and later do not support implicit
function declarations [-Wimplicit-function-declaration]
 2403 |         encode_get_dir_delegation(xdr, &hdr);
      |         ^


>  /*
>   * Encode a CLOSE request
>   */
> @@ -5919,6 +5990,43 @@ static int decode_layout_stateid(struct xdr_stream=
 *xdr, nfs4_stateid *stateid)
>         return decode_stateid(xdr, stateid);
>  }
>
> +static int decode_get_dir_delegation(struct xdr_stream *xdr,
> +                                    struct nfs4_getattr_res *res)
> +{
> +       nfs4_verifier   cookieverf;
> +       int             status;
> +       u32             bm[1];
> +
> +       status =3D decode_op_hdr(xdr, OP_GET_DIR_DELEGATION);
> +       if (status)
> +               return status;
> +
> +       if (xdr_stream_decode_u32(xdr, &res->nf_status))
> +               return -EIO;
> +
> +       if (res->nf_status =3D=3D GDD4_UNAVAIL)
> +               return xdr_inline_decode(xdr, 4) ? 0 : -EIO;
> +
> +       status =3D decode_verifier(xdr, &cookieverf);
> +       if (status)
> +               return status;
> +
> +       status =3D decode_delegation_stateid(xdr, &res->deleg);
> +       if (status)
> +               return status;
> +
> +       status =3D decode_bitmap4(xdr, bm, ARRAY_SIZE(bm));
> +       if (status < 0)
> +               return status;
> +       status =3D decode_bitmap4(xdr, bm, ARRAY_SIZE(bm));
> +       if (status < 0)
> +               return status;
> +       status =3D decode_bitmap4(xdr, bm, ARRAY_SIZE(bm));
> +       if (status < 0)
> +               return status;
> +       return 0;
> +}
> +
>  static int decode_getdeviceinfo(struct xdr_stream *xdr,
>                                 struct nfs4_getdeviceinfo_res *res)
>  {
> @@ -6455,6 +6563,33 @@ static int nfs4_xdr_dec_getattr(struct rpc_rqst *r=
qstp, struct xdr_stream *xdr,
>         return status;
>  }
>
> +/*
> + * Decode GDD_GETATTR response
> + */
> +static int nfs4_xdr_dec_gdd_getattr(struct rpc_rqst *rqstp, struct xdr_s=
tream *xdr,
> +                                   void *data)
> +{
> +       struct nfs4_getattr_res *res =3D data;
> +       struct compound_hdr hdr;
> +       int status;
> +
> +       status =3D decode_compound_hdr(xdr, &hdr);
> +       if (status)
> +               goto out;
> +       status =3D decode_sequence(xdr, &res->seq_res, rqstp);
> +       if (status)
> +               goto out;
> +       status =3D decode_putfh(xdr);
> +       if (status)
> +               goto out;
> +       status =3D decode_get_dir_delegation(xdr, res);
> +       if (status)
> +               goto out;
> +       status =3D decode_getfattr(xdr, res->fattr, res->server);
> +out:
> +       return status;
> +}
> +

This needs to be under the same #ifdef, too.

Thanks,
 Anna

>  /*
>   * Encode an SETACL request
>   */
> @@ -7704,6 +7839,7 @@ const struct rpc_procinfo nfs4_procedures[] =3D {
>         PROC41(BIND_CONN_TO_SESSION,
>                         enc_bind_conn_to_session, dec_bind_conn_to_sessio=
n),
>         PROC41(DESTROY_CLIENTID,enc_destroy_clientid,   dec_destroy_clien=
tid),
> +       PROC41(GDD_GETATTR,     enc_gdd_getattr,        dec_gdd_getattr),
>         PROC42(SEEK,            enc_seek,               dec_seek),
>         PROC42(ALLOCATE,        enc_allocate,           dec_allocate),
>         PROC42(DEALLOCATE,      enc_deallocate,         dec_deallocate),
> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> index 11ad088b411d..86cbfd50ecd1 100644
> --- a/include/linux/nfs4.h
> +++ b/include/linux/nfs4.h
> @@ -681,6 +681,7 @@ enum {
>         NFSPROC4_CLNT_LISTXATTRS,
>         NFSPROC4_CLNT_REMOVEXATTR,
>         NFSPROC4_CLNT_READ_PLUS,
> +       NFSPROC4_CLNT_GDD_GETATTR,
>  };
>
>  /* nfs41 types */
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index d09b9773b20c..85ee37ccc25e 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1072,6 +1072,8 @@ struct nfs4_getattr_res {
>         struct nfs4_sequence_res        seq_res;
>         const struct nfs_server *       server;
>         struct nfs_fattr *              fattr;
> +       nfs4_stateid                    deleg;
> +       u32                             nf_status;
>  };
>
>  struct nfs4_link_arg {
>
> --
> 2.44.0
>
