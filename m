Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8781F134A8
	for <netfs@lists.linux.dev>; Fri, 26 Jul 2024 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722007092; cv=none; b=WdzV1HuxyJxAl4oFexlcwKIj+tnfDBOMx/fnQGz7W1wY9jJxvxfIrxjlo6qIAeJsckAyx9/Zfu5mLqprTBKVPF8EMlA1/vnFVJF1Schy24/LfuW/pj0CRO0x1THbCnHbXWQNF6Wc2YiU3q2Qdvl6JrMsiFCC2v0j6+3WcDveTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722007092; c=relaxed/simple;
	bh=Sb2ulCWNz/P/u8y9m/osum0d1g67qa7Se1j3zRi58K4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qBSxh8O2eb2idXXpUes6AKD6rOFyQwnNQQcteT1lo2D3WsU4Lzo/avPpR2p7spvL3jKVFuHhow9loZOHw38CVh4mwF8f8a/Td6wz5RyhVlwhA0VuPNMhs4AwQFrBibUDki2hy7tIhllrbbUSHiDiU48eLFIGZ/dGy8NmNpB9QfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKrQyLqC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKrQyLqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED4CC32782;
	Fri, 26 Jul 2024 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722007092;
	bh=Sb2ulCWNz/P/u8y9m/osum0d1g67qa7Se1j3zRi58K4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mKrQyLqCkKPohx4kgz24Gi9y1OEkXbdm17OBPHpP+c8m69H0moTHTw5vCtwpxwIQ5
	 pfRbXmKzwMEL0DVfe727M9HLd8Wq6Wq47KG1r+YGoRpwmy7nUSj7FKpQrabQbit2p4
	 26DlUtZSlS9Vu1NImxArQXebEU7CM+mqXbzrE00e5YgsdWABIVeRj73YVu9Z53FC3o
	 KxB2Ubqva2E+stMTz+tPH4c7ewSFvudCRlEJ5z5jdn2EaPHo5LEj5gwKr9ZM0NIyrR
	 a6vOclb0Bt2NDtq+dWOcULo1BRIwMksAyD+Nu6pfHtNq/9xGkaGeBv4tL3IMx0ggEb
	 8n8tipZ+JLhbg==
Message-ID: <25e2e6bf4a63029857fce8398f2561684221e889.camel@kernel.org>
Subject: Re: [PATCH 1/2] netfs: Remove call to folio_index()
From: Jeff Layton <jlayton@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, David Howells
	 <dhowells@redhat.com>
Cc: netfs@lists.linux.dev
Date: Fri, 26 Jul 2024 11:18:10 -0400
In-Reply-To: <20240725220239.2247246-1-willy@infradead.org>
References: <20240725220239.2247246-1-willy@infradead.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Thu, 2024-07-25 at 23:02 +0100, Matthew Wilcox (Oracle) wrote:
> Calling folio_index() is pointless overhead; directly dereferencing
> folio->index is fine.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> =C2=A0include/trace/events/netfs.h | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/trace/events/netfs.h
> b/include/trace/events/netfs.h
> index da23484268df..5f199e01e888 100644
> --- a/include/trace/events/netfs.h
> +++ b/include/trace/events/netfs.h
> @@ -420,7 +420,7 @@ TRACE_EVENT(netfs_folio,
> =C2=A0	=C2=A0=C2=A0=C2=A0 TP_fast_assign(
> =C2=A0		=C2=A0=C2=A0=C2=A0 __entry->ino =3D folio->mapping->host->i_ino;
> =C2=A0		=C2=A0=C2=A0=C2=A0 __entry->why =3D why;
> -		=C2=A0=C2=A0=C2=A0 __entry->index =3D folio_index(folio);
> +		=C2=A0=C2=A0=C2=A0 __entry->index =3D folio->index;
> =C2=A0		=C2=A0=C2=A0=C2=A0 __entry->nr =3D folio_nr_pages(folio);
> =C2=A0			=C2=A0=C2=A0 ),
> =C2=A0

You can add this to both patches:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
