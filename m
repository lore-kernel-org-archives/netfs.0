Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577577;
	b=w0lmAPyXC7IR4ARKYBfw6natcwu7OubU6+iGePyMiBcQzYrXiC+R7zf234orTM68Vy+/
	 k2DiE9xFmS1atNURGFQUIJF2i5Ux/YEC5sNv2PKWjWDIr5AboqV2Xgm20qjtloCKIVNDQ
	 Di4E/ZV/EJXQ06BOcWcb9Lc7TALnCCwlb4x65vtu/xSHvzfvP8cSUKuvuuBmj0eoWsSWh
	 zHAwAHj5kMnwqKa/lQqkIorphxv1cjPceU+rWxYcXOZevUEvTO48ET718T1fet1OdfqC2
	 XctQTNCDx1C3wYmTZvTf1tnIzrSQbskJlgccMHPW8rnwx/Lk7DiOY/olbQZAD2vGhgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577577;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=HVAPo2TZEKjSrPR1lUHXhHo/4amIiTkFWSMPAQZAqsM=;
	b=k1DzGhUs60FuBcIl/rSZ3s1Kb/P+0jPHkwEP0GWQS5FwmCghhAnD6NCzZQR+haGoouOs
	 25fNRmu88ZIQqzWuKAjFiPKqukl+Lc/oQ0vIYw6EvOSs2F7UUgAxLyZKpoumtVN0lfEf2
	 ugrP48GUnMkZjMG7lhipILrJgPos32J2g4yiptKnIUHfvy5J9vnZxqwmDuiF3TA7t26jp
	 kGYqz/+x1db8t+bTRY0rYcBwZVNLL4+SYM5UXG1Ne0EiAxmv3XEjzarxg1nTE5D9w1aoH
	 0ettpWD3trHpOHMxKtmlCkvsXqIOFTlVV0hDq5FAL1VRSONY51UCB8sdWYNuXJ1Pa8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lxBX7bYP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF63C606A319;
	Wed, 21 Oct 2026 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lxBX7bYP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7871F000C9;
	Wed, 21 Oct 2026 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792577576;
	bh=HVAPo2TZEKjSrPR1lUHXhHo/4amIiTkFWSMPAQZAqsM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lxBX7bYPZaQ9rplmzLQzbb+rsc1SwxBUKjbNOSrD4q0RujUYKpSf1HR11I1+kDHLu
	 O7R0J5EnI2ozp874HKH00SQrG7DeW7/sMR3ne/jLyNNxWxNlGs036Od+LbiwAUITvJ
	 sQeKwVOLfoiMXisnGwxsEptNrewIrTx/N6U+IWyN2AR1mulHWNsra4tQhf1Kl/luol
	 WGCNG4YFbKpSen5YS6AnOjUSWmAIolrm+Mc08ILAHL1tFaVpo2nNRSfAKzxalyM6qb
	 rm393g4CtioKVZ4Cz/psaS9vak8/LxDczxF8PLgi+oNJfbKiI3l0ywpqm6aeOXIueW
	 TwtBOrYElt1Hg==
From: Christian Brauner <brauner@kernel.org>
To: dhowells@redhat.com, 
 Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261020090226.271-1-drifabdelmalekmohamedsaid@gmail.com>
References: <20261020090226.271-1-drifabdelmalekmohamedsaid@gmail.com>
Subject: Re: [PATCH] cachefiles: convert deprecated simple_strtoul() to
 kstrtoul() in percentage command handlers
Message-Id: <20261021-exilregierung-eliminieren-couch-2a7f5a7764c0@brauner>
Date: Wed, 21 Oct 2026 12:12:51 +0200
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aDPNVEZhnkxXvKUVe0eqNN/TxJiO7KktTc4wXiXDIU4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdmKA668aPeWXBtuYT2axXykcx5UyNdP+1b63Zr9I/K
 6dfumzxoKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiugkM/1NWZgZGvp3Rnf3U
 4/X7ujfnnvwqTPRaoXNqlttSU0d9o7OMDMet3tr6Rx/Le2/BlRV89X/yH3FXGSP12O2ZNhJ//l+
 cxQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Tue, 20 Oct 2026 10:02:26 +0100, Drif Abdelmalek Mohamed Said wrote:
> cachefiles: convert deprecated simple_strtoul() to kstrtoul() in percentage command handlers

Applied to the vfs-7.5.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.misc

[1/1] cachefiles: convert deprecated simple_strtoul() to kstrtoul() in percentage command handlers
      https://git.kernel.org/vfs/vfs/c/4a29e822cb99

